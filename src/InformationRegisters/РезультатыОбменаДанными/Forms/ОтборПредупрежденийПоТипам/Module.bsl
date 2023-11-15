///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Перем ОтборТипыПредупреждений;
	
	ПодсистемаВерсионированияСуществует = ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ВерсионированиеОбъектов");
	
	КэшЗначений = Новый Структура;
	КэшЗначений.Вставить("ПодсистемаВерсионированияСуществует", ПодсистемаВерсионированияСуществует);
	КэшЗначений.Вставить("НепринятыеДанныеПоКоллизии", Неопределено);
	КэшЗначений.Вставить("ПринятыеДанныеПоКоллизии", Неопределено);
	КэшЗначений.Вставить("НепринятыйПоДатеЗапретаОбъектНеСуществуетВБазе", Неопределено);
	КэшЗначений.Вставить("НепринятыйПоДатеЗапретаОбъектСуществуетВБазе", Неопределено);
	
	Если ПодсистемаВерсионированияСуществует Тогда
		
		МенеджерПеречисления = Перечисления["ТипыВерсийОбъекта"];
		КэшЗначений.НепринятыеДанныеПоКоллизии = МенеджерПеречисления.НепринятыеДанныеПоКоллизии;
		КэшЗначений.ПринятыеДанныеПоКоллизии = МенеджерПеречисления.ПринятыеДанныеПоКоллизии;
		КэшЗначений.НепринятыйПоДатеЗапретаОбъектНеСуществуетВБазе = МенеджерПеречисления.НепринятыйПоДатеЗапретаОбъектНеСуществуетВБазе;
		КэшЗначений.НепринятыйПоДатеЗапретаОбъектСуществуетВБазе = МенеджерПеречисления.НепринятыйПоДатеЗапретаОбъектСуществуетВБазе;
		
		Элементы.НепринятыйПоДатеЗапретаОбъектСуществуетВБазе.Видимость = Истина;
		Элементы.НепринятыйПоДатеЗапретаОбъектНеСуществуетВБазе.Видимость = Истина;
		Элементы.ПринятыеДанныеПоКоллизии.Видимость = Истина;
		Элементы.НепринятыеДанныеПоКоллизии.Видимость = Истина;
		
	КонецЕсли;
	
	Параметры.Свойство("ОтборТипыПредупреждений", ОтборТипыПредупреждений);
	ЗначенияОтбораТиповПредупрежденийВРеквизитыФормы(ОтборТипыПредупреждений);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	СоответствиеРеквизитов = Новый Соответствие;
	СоответствиеРеквизитов.Вставить("АдминистративнаяОшибкаПриложения", ПредопределенноеЗначение("Перечисление.ТипыПроблемОбменаДанными.АдминистративнаяОшибкаПриложения"));
	СоответствиеРеквизитов.Вставить("НезаполненныеРеквизиты", ПредопределенноеЗначение("Перечисление.ТипыПроблемОбменаДанными.НезаполненныеРеквизиты"));
	СоответствиеРеквизитов.Вставить("НепроведенныйДокумент", ПредопределенноеЗначение("Перечисление.ТипыПроблемОбменаДанными.НепроведенныйДокумент"));
	СоответствиеРеквизитов.Вставить("ОшибкаПроверкиПередОтправкойXTDO", ПредопределенноеЗначение("Перечисление.ТипыПроблемОбменаДанными.ОшибкаПроверкиСконвертированногоОбъекта"));
	СоответствиеРеквизитов.Вставить("ОшибкаВыполненияКодаОбработчиковПриПолученииДанных", ПредопределенноеЗначение("Перечисление.ТипыПроблемОбменаДанными.ОшибкаВыполненияКодаОбработчиковПриПолученииДанных"));
	СоответствиеРеквизитов.Вставить("ОшибкаВыполненияКодаОбработчиковПриОтправкеДанных", ПредопределенноеЗначение("Перечисление.ТипыПроблемОбменаДанными.ОшибкаВыполненияКодаОбработчиковПриОтправкеДанных"));
	
	Если КэшЗначений.ПодсистемаВерсионированияСуществует Тогда
		
		СоответствиеРеквизитов.Вставить("НепринятыеДанныеПоКоллизии", КэшЗначений.НепринятыеДанныеПоКоллизии);
		СоответствиеРеквизитов.Вставить("ПринятыеДанныеПоКоллизии", КэшЗначений.ПринятыеДанныеПоКоллизии);
		СоответствиеРеквизитов.Вставить("НепринятыйПоДатеЗапретаОбъектНеСуществуетВБазе", КэшЗначений.НепринятыйПоДатеЗапретаОбъектНеСуществуетВБазе);
		СоответствиеРеквизитов.Вставить("НепринятыйПоДатеЗапретаОбъектСуществуетВБазе", КэшЗначений.НепринятыйПоДатеЗапретаОбъектСуществуетВБазе);
		
	КонецЕсли;
	
	ОтборТипыПредупреждений = Новый Массив;
	Для каждого ЗначениеСоответствия Из СоответствиеРеквизитов Цикл
		
		Если ЭтотОбъект[ЗначениеСоответствия.Ключ] Тогда
			
			ОтборТипыПредупреждений.Добавить(ЗначениеСоответствия.Значение);
			
		КонецЕсли;
		
	КонецЦикла;
	
	Закрыть(ОтборТипыПредупреждений);
	
КонецПроцедуры

&НаКлиенте
Процедура Сбросить(Команда)
	
	АдминистративнаяОшибкаПриложения = Ложь;
	НезаполненныеРеквизиты = Ложь;
	НепроведенныйДокумент = Ложь;
	ОшибкаПроверкиПередОтправкойXTDO = Ложь;
	ОшибкаВыполненияКодаОбработчиковПриПолученииДанных = Ложь;
	ОшибкаВыполненияКодаОбработчиковПриОтправкеДанных = Ложь;
	НепринятыеДанныеПоКоллизии = Ложь;
	НепринятыйПоДатеЗапретаОбъектНеСуществуетВБазе = Ложь;
	НепринятыйПоДатеЗапретаОбъектСуществуетВБазе = Ложь;
	ПринятыеДанныеПоКоллизии = Ложь;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗначенияОтбораТиповПредупрежденийВРеквизитыФормы(ОтборТипыПредупреждений)
	
	Если ТипЗнч(ОтборТипыПредупреждений) <> Тип("Массив") Тогда
		
		Возврат;
		
	КонецЕсли;
		
	СоответствиеРеквизитов = Новый Соответствие;
	СоответствиеРеквизитов.Вставить(Перечисления.ТипыПроблемОбменаДанными.АдминистративнаяОшибкаПриложения, "АдминистративнаяОшибкаПриложения");
	СоответствиеРеквизитов.Вставить(Перечисления.ТипыПроблемОбменаДанными.НезаполненныеРеквизиты, "НезаполненныеРеквизиты");
	СоответствиеРеквизитов.Вставить(Перечисления.ТипыПроблемОбменаДанными.НепроведенныйДокумент, "НепроведенныйДокумент");
	СоответствиеРеквизитов.Вставить(Перечисления.ТипыПроблемОбменаДанными.ОшибкаПроверкиСконвертированногоОбъекта, "ОшибкаПроверкиПередОтправкойXTDO");
	СоответствиеРеквизитов.Вставить(Перечисления.ТипыПроблемОбменаДанными.ОшибкаВыполненияКодаОбработчиковПриПолученииДанных, "ОшибкаВыполненияКодаОбработчиковПриПолученииДанных");
	СоответствиеРеквизитов.Вставить(Перечисления.ТипыПроблемОбменаДанными.ОшибкаВыполненияКодаОбработчиковПриОтправкеДанных, "ОшибкаВыполненияКодаОбработчиковПриОтправкеДанных");
	
	Если КэшЗначений.ПодсистемаВерсионированияСуществует Тогда
		
		СоответствиеРеквизитов.Вставить(КэшЗначений.НепринятыеДанныеПоКоллизии, "НепринятыеДанныеПоКоллизии");
		СоответствиеРеквизитов.Вставить(КэшЗначений.ПринятыеДанныеПоКоллизии, "ПринятыеДанныеПоКоллизии");
		СоответствиеРеквизитов.Вставить(КэшЗначений.НепринятыйПоДатеЗапретаОбъектНеСуществуетВБазе, "НепринятыйПоДатеЗапретаОбъектНеСуществуетВБазе");
		СоответствиеРеквизитов.Вставить(КэшЗначений.НепринятыйПоДатеЗапретаОбъектСуществуетВБазе, "НепринятыйПоДатеЗапретаОбъектСуществуетВБазе");
		
	КонецЕсли;
	
	Для каждого ТипПредупреждения Из ОтборТипыПредупреждений Цикл
		
		ЭтотОбъект[СоответствиеРеквизитов[ТипПредупреждения]] = Истина;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти