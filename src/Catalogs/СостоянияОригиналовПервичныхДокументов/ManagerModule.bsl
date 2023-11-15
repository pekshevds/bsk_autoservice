///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Смотри также ОбновлениеИнформационнойБазыПереопределяемый.ПриНастройкеНачальногоЗаполненияЭлементов
// 
// Параметры:
//  Настройки - см. ОбновлениеИнформационнойБазыПереопределяемый.ПриНастройкеНачальногоЗаполненияЭлементов.Настройки
//
Процедура ПриНастройкеНачальногоЗаполненияЭлементов(Настройки) Экспорт

	Настройки.ПриНачальномЗаполненииЭлемента = Ложь;

КонецПроцедуры

// Смотри также ОбновлениеИнформационнойБазыПереопределяемый.ПриНачальномЗаполненииЭлементов
// 
// Параметры:
//   КодыЯзыков - см. ОбновлениеИнформационнойБазыПереопределяемый.ПриНачальномЗаполненииЭлементов.КодыЯзыков
//   Элементы - см. ОбновлениеИнформационнойБазыПереопределяемый.ПриНачальномЗаполненииЭлементов.Элементы
//   ТабличныеЧасти - см. ОбновлениеИнформационнойБазыПереопределяемый.ПриНачальномЗаполненииЭлементов.ТабличныеЧасти
//
Процедура ПриНачальномЗаполненииЭлементов(КодыЯзыков, Элементы, ТабличныеЧасти) Экспорт

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ФормаНапечатана";
	Элемент.Наименование = НСтр("ru='Форма напечатана'", ОбщегоНазначения.КодОсновногоЯзыка());
	Элемент.Описание = НСтр("ru='Состояние, означающее, что  печатная форма только печаталась.'", ОбщегоНазначения.КодОсновногоЯзыка());
	Элемент.Код = "000000001";
	Элемент.РеквизитДопУпорядочивания = "1";

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ОригиналыНеВсе";
	Элемент.Наименование = НСтр("ru='Оригиналы не все'", ОбщегоНазначения.КодОсновногоЯзыка());
	Элемент.Описание = НСтр("ru='Общее состояние для документа, у которого оригиналы печатных форм находятся в разных состояниях.'", ОбщегоНазначения.КодОсновногоЯзыка());
	Элемент.Код = "000000002";
	Элемент.РеквизитДопУпорядочивания = "99998";

	Элемент = Элементы.Добавить();
	Элемент.ИмяПредопределенныхДанных = "ОригиналПолучен";
	Элемент.Наименование = НСтр("ru='Оригинал получен'", ОбщегоНазначения.КодОсновногоЯзыка());
	Элемент.Описание = НСтр("ru='Состояние, означающее, что подписанный оригинал печатной формы есть в наличии.'", ОбщегоНазначения.КодОсновногоЯзыка());
	Элемент.Код = "000000003";
	Элемент.РеквизитДопУпорядочивания = "99999";

КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// Обработчики обновления.

// Регистрирует на плане обмена ОбновлениеИнформационнойБазы объекты,
// которые необходимо обновить на новую версию.
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	СостоянияОригиналовПервичныхДокументов.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.СостоянияОригиналовПервичныхДокументов КАК СостоянияОригиналовПервичныхДокументов
		|
		|УПОРЯДОЧИТЬ ПО
		|	СостоянияОригиналовПервичныхДокументов.РеквизитДопУпорядочивания";
	
	Результат = Запрос.Выполнить().Выгрузить();
	МассивСсылок = Результат.ВыгрузитьКолонку("Ссылка");
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, МассивСсылок);
	
КонецПроцедуры

// Заполнить значение служебного реквизита РеквизитДопУпорядочивания у справочника СостоянияОригиналовПервичныхДокументов.
// 
Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
		
	Выборка = ОбновлениеИнформационнойБазы.ВыбратьСсылкиДляОбработки(Параметры.Очередь, "Справочник.СостоянияОригиналовПервичныхДокументов");
	
	СостояниеПорядок = Новый ТаблицаЗначений();
	СостояниеПорядок.Колонки.Добавить("Ссылка");
	СостояниеПорядок.Колонки.Добавить("Порядок");

	Пока Выборка.Следующий() Цикл
		ТекСостояние = СостояниеПорядок.Добавить();
		ТекСостояние.Ссылка = Выборка.Ссылка;
		ТекСостояние.Порядок = Выборка.Ссылка.РеквизитДопУпорядочивания;
	КонецЦикла;
	
	СостояниеПорядок.Сортировать("Порядок");
	
	ПроблемныхОбъектов = 0;
	ОбъектовОбработано = 0;
	
	Порядок = 2;
	
	Для Каждого СостояниеИзм Из СостояниеПорядок Цикл
		
		Попытка
			
			Если СостояниеИзм.Ссылка = Справочники.СостоянияОригиналовПервичныхДокументов.ФормаНапечатана Тогда
				ЗаполнитьРеквизитРеквизитДопУпорядочивания(СостояниеИзм, 1);
				ОбъектовОбработано = ОбъектовОбработано + 1;
			ИначеЕсли СостояниеИзм.Ссылка = Справочники.СостоянияОригиналовПервичныхДокументов.ОригиналыНеВсе Тогда
				ЗаполнитьРеквизитРеквизитДопУпорядочивания(СостояниеИзм, 99998);
				ОбъектовОбработано = ОбъектовОбработано + 1;
			ИначеЕсли СостояниеИзм.Ссылка = Справочники.СостоянияОригиналовПервичныхДокументов.ОригиналПолучен Тогда
			    ЗаполнитьРеквизитРеквизитДопУпорядочивания(СостояниеИзм, 99999);
				ОбъектовОбработано = ОбъектовОбработано + 1;
			Иначе
				ЗаполнитьРеквизитРеквизитДопУпорядочивания(СостояниеИзм, Порядок);
				ОбъектовОбработано = ОбъектовОбработано + 1;
				Порядок = Порядок + 1;
			КонецЕсли;
			
		Исключение
			// Если не удалось обработать состояние, повторяем попытку снова.
			ПроблемныхОбъектов = ПроблемныхОбъектов + 1;
			
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Не удалось обработать %1 по причине:
					|%2'"), 
					СостояниеИзм.Ссылка, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Предупреждение,
				Метаданные.Справочники.СостоянияОригиналовПервичныхДокументов, СостояниеИзм.Ссылка, ТекстСообщения);
		КонецПопытки;
		
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Параметры.Очередь, "Справочник.СостоянияОригиналовПервичныхДокументов");
	Если ОбъектовОбработано = 0 И ПроблемныхОбъектов <> 0 Тогда
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Не удалось обработать некоторые состояния оригиналов первичных документов (пропущены): %1'"), 
				ПроблемныхОбъектов);
		ВызватьИсключение ТекстСообщения;
	Иначе
		ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Информация,
			Метаданные.Справочники.СостоянияОригиналовПервичныхДокументов,,
				СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'Обработана очередная порция состояния оригиналов первичных документов: %1'"),
					ОбъектовОбработано));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Перезаполняет значение служебного реквизита РеквизитДопУпорядочивания у переданного элемента.
//
Процедура ЗаполнитьРеквизитРеквизитДопУпорядочивания(Выборка, Порядок)
	
	НачатьТранзакцию();
	Попытка
	
		// Блокируем объект от изменения другими сеансами.
		Блокировка = Новый БлокировкаДанных;
		ЭлементБлокировки = Блокировка.Добавить("Справочник.СостоянияОригиналовПервичныхДокументов");
		ЭлементБлокировки.УстановитьЗначение("Ссылка", Выборка.Ссылка);
		Блокировка.Заблокировать();
		
		СостояниеОбъект = Выборка.Ссылка.ПолучитьОбъект();
		
		// Если объект ранее был удален или обработан другими сеансами, пропускаем его.
		Если СостояниеОбъект = Неопределено Тогда
			ОтменитьТранзакцию();
			Возврат;
		КонецЕсли;
		
		// Обработка объекта.
		СостояниеОбъект.РеквизитДопУпорядочивания = Порядок;
		
		// Запись обработанного объекта.
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(СостояниеОбъект);
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли

