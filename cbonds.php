<?php

class TestCbondS{

	const URI 		= 'http://www.cbonds.info/sandbox/some_source.php';
	const FILENAME 	= './server_data.html';
	const XML 		= './emissions.xml';
	const XSL 		= './style.xsl';

	private function checkCurlResponse($code){
		
		$code = (int)$code;
		$errors = array(
			301 => 'Moved permanently',
			400 => 'Bad request',
			401 => 'Unauthorized',
			403 => 'Forbidden',
			404 => 'Not found',
			500 => 'Internal server error',
			502 => 'Bad gateway',
			503 => 'Service unavailable'
		);
		try {
			if ($code != 200 && $code != 204){
			  throw new Exception(isset($errors[$code]) ? $errors[$code] : 'Undescribed error',$code);
			}
		} catch(Exception $E) {
			die('Error: '.$E->getMessage().PHP_EOL.'Error code: '.$E->getCode());
		}
	}

	public function loadHtml(){
		
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, self::URI);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
		curl_setopt($ch, CURLOPT_TIMEOUT, 60);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
		curl_setopt($ch, CURLOPT_MAXREDIRS, 5);
		curl_setopt($ch, CURLOPT_COOKIEFILE,dirname(__FILE__).'/cookie.txt');
		curl_setopt($ch, CURLOPT_COOKIEJAR,dirname(__FILE__).'/cookie.txt');
		curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.94 Safari/537.36');
        $content = curl_exec($ch);
        $code = curl_getinfo($ch,CURLINFO_HTTP_CODE);
        curl_close($ch);
        $this->checkCurlResponse($code);
        file_put_contents(self::FILENAME,$content);
	}

	public function parseHtml(){
		
		$titleArray = array('Эмитент','Эмитент (кратко)','Тип','Выпуск','Номинал (р.)','Дата гос. регистрации',
							'Дата регистрации отчета / Уведомления об итогах','Код гос. регистрации','Код ДКК',
							'Код РТС','ISIN','Наличие блокировок','CFI','Лицевой счет ДКК','Вариант обслуживания','Наименование выпуска');
		
		// Можно было спарсить из таблички, но так как заголовки статичные, заведены вручную.

		$content = file_get_contents(self::FILENAME);

		preg_match('|<table id="stable"[^>]*?>(.*?)<tbody>(.*?)</tbody>(.*?)</table>|sei',$content,$matches);
		$tbody = $matches[2];
		preg_match_all('/<tr>(.*?)<\/tr>/sei',$tbody,$matches);
		$lines = $matches[1];
		
		$tableArray = array();
		foreach ($lines as $key => $value){
			preg_match_all('/<td[^>]*?>(.*?)<\/td>/sei',$value,$cells);
			foreach ($cells[1] as $num => $text){
				$tableArray[$key][$num] = trim($text);
			}
		}

		// Можно сделать в один проход, но для удобства отладки и лучшей читаемости
		// был добавлен массив и формирование xml производится на его основе

		$dom = new DOMDocument( "1.0", "utf-8" );
		$items = $dom->appendChild(new DOMElement('items'));
		foreach ($tableArray as $line) {
			$item = $items->appendChild(new DOMElement('item'));
			foreach ($line as $num => $text){
				$prop = $item->appendChild(new DOMElement('property'));
				$prop->setAttribute('title',$titleArray[$num]);
				$prop->appendChild(new DOMCdataSection($text));
			}
		}		

		file_put_contents(self::XML,$dom->saveXML());
	}

	public function makeHtml(){

		$xsldoc = new DOMDocument();
		$xsldoc->load(self::XSL);

		$xmldoc = new DOMDocument();
		$xmldoc->load(self::XML);

		$xsl = new XSLTProcessor();
		$xsl->importStyleSheet($xsldoc);
		
		echo $xsl->transformToXML($xmldoc);
	}

}

$obj = new TestCbondS();
$obj->loadHtml();
$obj->parseHtml();
$obj->makeHtml();


/*

1-3 задания
Страничка в cp1251, а табличка в utf-8. Данные в cp1251 не используются, поэтому к одной кодировке не приводил.
Кода немного и функционала тоже, можно все было вынести в отдельные классы, но смысла разбивать для небольшой задачи наверное нет.
В php 5.2 работоспособность проверялась

4-е задание
Так как по заданию не определить точно тип и размер у всех полей, для данных полей был использован varchar.
Если выпуск всегда числовое значение то его можно заменить на int
Так же неизвестно содержание поля Наличие блокировок, если оно булево, то можно сделать его int(1). Но возможно туда вписывается строка, поэтому оно сделано varchar(255)
Аналогично с вариантом обслуживания. Если вариантов немного - можно перевести его на enum.
Дамп БД в файле cbonds.sql
Схема - scheme.jpg

5-е задание
для полного названия эмитента можно заменить em.short_name на em.full_name

SELECT 
	bt.title,sum(em.price) as sum_price,GROUP_CONCAT(em.short_name SEPARATOR ', ') as short_names
FROM 
	`emitents` em
LEFT JOIN 
	`bond_types` bt 
ON (em.type = bt.id)
GROUP BY em.type
ORDER BY sum_price DESC

*/