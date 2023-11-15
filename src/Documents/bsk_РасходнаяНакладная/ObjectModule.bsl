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
	Склад			 = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Автор, "bsk_ОсновнойСклад");
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ                             
	|	Материалы.НомерСтроки КАК НомерСтроки,
	|	&ВидДвижения КАК ВидДвижения,
	|	Материалы.Ссылка.Дата КАК Период,
	|	Материалы.Номенклатура КАК Номенклатура,
	|	Материалы.Количество КАК Количество,
	|	Материалы.Ссылка.Склад КАК Склад
	|ИЗ
	|	Документ.bsk_РасходнаяНакладная.Материалы КАК Материалы
	|ГДЕ
	|	Материалы.Ссылка = &СсылкаНаОбъект
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";
	
	Запрос.УстановитьПараметр("СсылкаНаОбъект", Ссылка);
	Запрос.УстановитьПараметр("ВидДвижения", ВидДвиженияНакопления.Расход);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();                                             
	
    РегистрыНакопления.bsk_МатериалыНаСкладах.ВыполнитьДвижение(Ссылка, Выборка);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	СуммаДокумента = Материалы.Итог("Сумма");		
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