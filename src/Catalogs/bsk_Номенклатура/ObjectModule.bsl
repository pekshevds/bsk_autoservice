
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

#КонецОбласти

#Область ПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиСобытий



Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		
		Возврат;
	КонецЕсли;
КонецПроцедуры


Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Автор = Пользователи.ТекущийПользователь();
	ЕдиницаИзмерения = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Автор, "bsk_ОсновнаяЕдиницаИзмерения");
	
КонецПроцедуры


#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти

#Область Инициализация

#КонецОбласти

#КонецЕсли
