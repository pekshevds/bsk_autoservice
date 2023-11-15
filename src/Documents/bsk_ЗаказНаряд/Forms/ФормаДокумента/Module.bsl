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
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКоманды = ОбщегоНазначения.ОбщийМодуль("ПодключаемыеКоманды");
		МодульПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды 		
КонецПроцедуры   

&НаКлиенте
Процедура ПриОткрытии(Отказ)  
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКомандыКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиент");
		МодульПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКомандыКлиентСервер = ОбщегоНазначения.ОбщийМодуль("ПодключаемыеКомандыКлиентСервер");
		МодульПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКомандыКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиент");
		МодульПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыМатериалы

&НаКлиенте
Процедура МатериалыНоменклатураПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Материалы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		
		ТекущаяСтрока = ИнициализацияМатериалы();
		
		ЗаполнитьЗначенияСвойств(ТекущаяСтрока, ТекущиеДанные);
		ПриИзмененииМатериалыНаСервере(ТекущаяСтрока);		
		ЗаполнитьЗначенияСвойств(ТекущиеДанные, ТекущаяСтрока);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура МатериалыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Материалы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		
		ТекущаяСтрока = ИнициализацияМатериалы();
		
		ЗаполнитьЗначенияСвойств(ТекущаяСтрока, ТекущиеДанные);
		ПриИзмененииМатериалыНаСервере(ТекущаяСтрока);		
		ЗаполнитьЗначенияСвойств(ТекущиеДанные, ТекущаяСтрока);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура МатериалыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Материалы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		
		ТекущаяСтрока = ИнициализацияМатериалы();
		
		ЗаполнитьЗначенияСвойств(ТекущаяСтрока, ТекущиеДанные);
		ПриИзмененииМатериалыНаСервере(ТекущаяСтрока);		
		ЗаполнитьЗначенияСвойств(ТекущиеДанные, ТекущаяСтрока);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыРаботы

&НаКлиенте
Процедура РаботыНоменклатураПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Работы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		
		ТекущаяСтрока = ИнициализацияРаботы();
		
		ЗаполнитьЗначенияСвойств(ТекущаяСтрока, ТекущиеДанные);
		ПриИзмененииРаботыНаСервере(ТекущаяСтрока);		
		ЗаполнитьЗначенияСвойств(ТекущиеДанные, ТекущаяСтрока);
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура РаботыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Работы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		
		ТекущаяСтрока = ИнициализацияРаботы();
		
		ЗаполнитьЗначенияСвойств(ТекущаяСтрока, ТекущиеДанные);
		ПриИзмененииРаботыНаСервере(ТекущаяСтрока);		
		ЗаполнитьЗначенияСвойств(ТекущиеДанные, ТекущаяСтрока);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура РаботыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Работы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		
		ТекущаяСтрока = ИнициализацияРаботы();
		
		ЗаполнитьЗначенияСвойств(ТекущаяСтрока, ТекущиеДанные);
		ПриИзмененииРаботыНаСервере(ТекущаяСтрока);		
		ЗаполнитьЗначенияСвойств(ТекущиеДанные, ТекущаяСтрока);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура РаботыКоэффициентПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Работы.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		
		ТекущаяСтрока = ИнициализацияРаботы();
		
		ЗаполнитьЗначенияСвойств(ТекущаяСтрока, ТекущиеДанные);
		ПриИзмененииРаботыНаСервере(ТекущаяСтрока);		
		ЗаполнитьЗначенияСвойств(ТекущиеДанные, ТекущаяСтрока);
	КонецЕсли;
КонецПроцедуры




#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ИнициализацияМатериалы()
	
	Структура = Новый Структура;
	Структура.Вставить("Номенклатура", Справочники.bsk_Номенклатура.ПустаяСсылка());
	Структура.Вставить("Количество", 1);
	Структура.Вставить("Цена", 0);
	Структура.Вставить("Сумма", 0);
	Возврат Структура;
КонецФункции

&НаСервере
Функция ИнициализацияРаботы()
	
	Структура = ИнициализацияМатериалы();
	Структура.Вставить("Коэффициент", 1);
	Возврат Структура;
КонецФункции

&НаСервере
Процедура ПриИзмененииМатериалыНаСервере(ТекущаяСтрока)
	
	ТекущаяСтрока.Сумма = ТекущаяСтрока.Количество * ТекущаяСтрока.Цена;
КонецПроцедуры

&НаСервере
Процедура ПриИзмененииРаботыНаСервере(ТекущаяСтрока)
	
	ТекущаяСтрока.Сумма = ТекущаяСтрока.Количество * ТекущаяСтрока.Цена * ТекущаяСтрока.Коэффициент;
КонецПроцедуры

// Управляет доступностью элементов формы.
&НаКлиенте
Процедура УправлениеДоступностью()
	

КонецПроцедуры

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	МодульПодключаемыеКомандыКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиент");
	МодульПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	МодульПодключаемыеКоманды = ОбщегоНазначения.ОбщийМодуль("ПодключаемыеКоманды");
	МодульПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	МодульПодключаемыеКомандыКлиентСервер = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиентСервер");
	МодульПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти 

