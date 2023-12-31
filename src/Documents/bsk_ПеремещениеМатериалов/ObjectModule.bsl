///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс


#Область ДляВызоваИзДругихПодсистем

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
    	
	Ответственный    = Пользователи.ТекущийПользователь();
	Автор            = Пользователи.ТекущийПользователь();
	Организация		 = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Автор, "bsk_ОсновнаяОрганизация");
	СкладОтправитель = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Автор, "bsk_ОсновнойСклад");
	СкладПолучатель  = СкладОтправитель;
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	&ВидДвиженияПриход КАК ВидДвижения,
	|	Материалы.Ссылка.Дата КАК Период,
	|	Материалы.Номенклатура КАК Номенклатура,
	|	Материалы.Количество КАК Количество,
	|	Материалы.Ссылка.СкладОтправитель КАК Склад
	|ПОМЕСТИТЬ втПриход
	|ИЗ
	|	Документ.bsk_ПеремещениеМатериалов.Материалы КАК Материалы
	|ГДЕ
	|	Материалы.Ссылка = &СсылкаНаОбъект
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	&ВидДвиженияРасход КАК ВидДвижения,
	|	Материалы.Ссылка.Дата КАК Период,
	|	Материалы.Номенклатура КАК Номенклатура,
	|	Материалы.Количество КАК Количество,
	|	Материалы.Ссылка.СкладПолучатель КАК Склад
	|ПОМЕСТИТЬ втРасход
	|ИЗ
	|	Документ.bsk_ПеремещениеМатериалов.Материалы КАК Материалы
	|ГДЕ
	|	Материалы.Ссылка = &СсылкаНаОбъект
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВложенныйЗапрос.ВидДвижения,
	|	ВложенныйЗапрос.Период,
	|	ВложенныйЗапрос.Номенклатура,
	|	СУММА(ВложенныйЗапрос.Количество) КАК Количество,
	|	ВложенныйЗапрос.Склад
	|ИЗ
	|	(ВЫБРАТЬ
	|		втПриход.ВидДвижения,
	|		втПриход.Период,
	|		втПриход.Номенклатура,
	|		втПриход.Количество,
	|		втПриход.Склад
	|	ИЗ
	|		втПриход КАК втПриход
	|
	|	ОБЪЕДИНИТЬ ВСЕ
	|
	|	ВЫБРАТЬ
	|		втРасход.ВидДвижения,
	|		втРасход.Период,
	|		втРасход.Номенклатура,
	|		втРасход.Количество,
	|		втРасход.Склад
	|	ИЗ
	|		втРасход КАК втРасход) КАК ВложенныйЗапрос
	|СГРУППИРОВАТЬ ПО
	|	ВложенныйЗапрос.Склад,
	|	ВложенныйЗапрос.Номенклатура,
	|	ВложенныйЗапрос.Период,
	|	ВложенныйЗапрос.ВидДвижения";
	
	Запрос.УстановитьПараметр("СсылкаНаОбъект", ЭтотОбъект.Ссылка);
	Запрос.УстановитьПараметр("ВидДвиженияПриход", ВидДвиженияНакопления.Приход);
	Запрос.УстановитьПараметр("ВидДвиженияРасход", ВидДвиженияНакопления.Расход);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();                                             
	
    РегистрыНакопления.bsk_МатериалыНаСкладах.ВыполнитьДвижение(ЭтотОбъект.Ссылка, Выборка);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
		
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
		
	Ответственный    = Пользователи.ТекущийПользователь();
	Автор            = Пользователи.ТекущийПользователь();
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
    
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
		
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли