///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
		
	// Реестр документов
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Идентификатор = "ПечатнаяФорма";
	КомандаПечати.Представление = НСтр("ru = 'Печатная Форма'");
	КомандаПечати.ЗаголовокФормы= НСтр("ru = 'Печатная Форма'");
	КомандаПечати.СписокФорм    = "ФормаДокумента,ФормаСписка";
	КомандаПечати.ДополнительныеПараметры.Вставить("НеВыводитьВКомплекте",Истина);
	КомандаПечати.Порядок       = 10;	
	
КонецПроцедуры

// Сформировать печатные формы объектов
//
// ВХОДЯЩИЕ:
//   ИменаМакетов    - Строка    - Имена макетов, перечисленные через запятую
//   МассивОбъектов  - Массив    - Массив ссылок на объекты которые нужно распечатать
//   ПараметрыПечати - Структура - Структура дополнительных параметров печати
//
// ИСХОДЯЩИЕ:
//   КоллекцияПечатныхФорм - Таблица значений - Сформированные табличные документы
//   ПараметрыВывода       - Структура        - Параметры сформированных табличных документов
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПечатнаяФорма") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(КоллекцияПечатныхФорм, "ПечатнаяФорма", "Печатная форма", 
			ПечатьДокумента(МассивОбъектов, ОбъектыПечати, ПараметрыПечати),,"Документ.bsk_ПеремещениеМатериалов.ПФ_MXL_ПечатнаяФорма");
	КонецЕсли;
		
КонецПроцедуры

// Функция формирует табличный документ с печатной формой накладной,
//
// Возвращаемое значение:
//  Табличный документ - печатная форма накладной
//
Функция ПечатьДокумента(МассивОбъектов, ОбъектыПечати, ПараметрыПечати)

	УстановитьПривилегированныйРежим(Истина);
	
	ТабличныйДокумент = Новый ТабличныйДокумент;
	ТабличныйДокумент.АвтоМасштаб			= Истина;
	ТабличныйДокумент.ОриентацияСтраницы	= ОриентацияСтраницы.Портрет;
	ТабличныйДокумент.КлючПараметровПечати	= "ПАРАМЕТРЫ_ПЕЧАТИ_ПеремещениеМатериалов_ПечатнаяФорма";
			
	Запрос = Новый Запрос();
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Документ.Ссылка КАК Ссылка,
	|	Документ.Номер КАК Номер,
	|	Документ.Дата КАК Дата,
	|	Документ.Автор КАК Автор,
	|	Документ.Ответственный КАК Ответственный,
	|	Документ.Материалы.(
	|		Ссылка КАК Ссылка,
	|		НомерСтроки КАК НомерСтроки,
	|		Номенклатура КАК Номенклатура,
	|		Номенклатура.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|		Количество КАК Количество) КАК Материалы,
	|	Документ.Организация,
	|	Документ.СкладПолучатель,
	|	Документ.СкладОтправитель,
	|	Документ.Ответственный
	|ИЗ
	|	Документ.bsk_ПеремещениеМатериалов КАК Документ
	|ГДЕ
	|	Документ.Ссылка В (&МассивОбъектов)";
	
	Шапка = Запрос.Выполнить().Выбрать();
	
	ПервыйДокумент = Истина;
	
	Пока Шапка.СледующийПоЗначениюПоля("Ссылка") Цикл
		
		Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.bsk_ПеремещениеМатериалов.ПФ_MXL_ПечатнаяФорма");

		Если НЕ ПервыйДокумент Тогда
			ТабличныйДокумент.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		
		ПервыйДокумент = Ложь;
		// Запомним номер строки, с которой начали выводить текущий документ.
		НомерСтрокиНачало = ТабличныйДокумент.ВысотаТаблицы + 1;
		
		// Выводим шапку накладной

		ОбластьМакета = Макет.ПолучитьОбласть("Заголовок");
		ОбластьМакета.Параметры.Заполнить(Шапка);		
		ОбластьМакета.Параметры.Заголовок = 
			СтрШаблон("Накладная на перемещение %1 от %2", Шапка.Номер, Формат(Шапка.Дата, "ДФ=dd.MM.yyyy"));		
		ТабличныйДокумент.Вывести(ОбластьМакета);

		ОбластьМакета = Макет.ПолучитьОбласть("Шапка");		
		ТабличныйДокумент.Вывести(ОбластьМакета);

		
		Материалы = Шапка.Материалы.Выбрать();
		Пока Материалы.Следующий() Цикл 
			
			ОбластьМакета = Макет.ПолучитьОбласть("Строка");
			ОбластьМакета.Параметры.Заполнить(Материалы);
			ТабличныйДокумент.Вывести(ОбластьМакета);
		КонецЦикла;		
		
		ОбластьМакета = Макет.ПолучитьОбласть("Подвал");
		ОбластьМакета.Параметры.Заполнить(Шапка);		
		ТабличныйДокумент.Вывести(ОбластьМакета);

		
		// В табличном документе зададим имя области, в которую был 
		// выведен объект. Нужно для возможности печати покомплектно.
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабличныйДокумент, 
			НомерСтрокиНачало, ОбъектыПечати, Шапка.Ссылка);		
	КонецЦикла;

	Возврат ТабличныйДокумент;

КонецФункции

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

// Возвращает реквизиты объекта, которые разрешается редактировать
// с помощью обработки группового изменения реквизитов.
//
// Возвращаемое значение:
//  Массив из Строка
//
Функция РеквизитыРедактируемыеВГрупповойОбработке() Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить("Автор");	
	Результат.Добавить("Ответственный");	
	Результат.Добавить("Комментарий");
	Возврат Результат;
	
КонецФункции

// Конец СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

// СтандартныеПодсистемы.Взаимодействия

// Конец СтандартныеПодсистемы.Взаимодействия

// СтандартныеПодсистемы.УправлениеДоступом

// Параметры:
//   Ограничение - см. УправлениеДоступомПереопределяемый.ПриЗаполненииОграниченияДоступа.Ограничение.
//
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Ответственный, Отключено КАК Ложь)
	|	ИЛИ ЗначениеРазрешено(Автор, Отключено КАК Ложь)";
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

// СтандартныеПодсистемы.ПодключаемыеКоманды

// Определяет список команд создания на основании.
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//  Параметры - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.Параметры
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	
	ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	
КонецПроцедуры

// Для использования в процедуре ДобавитьКомандыСозданияНаОсновании других модулей менеджеров объектов.
// Добавляет в список команд создания на основании этот объект.
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//
// Возвращаемое значение:
//  СтрокаТаблицыЗначений, Неопределено - описание добавленной команды.
//
Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	
	Команда = СозданиеНаОсновании.ДобавитьКомандуСозданияНаОсновании(КомандыСозданияНаОсновании, Метаданные.Документы.Встреча);
	Если Команда <> Неопределено Тогда
		Команда.ФункциональныеОпции = "ИспользоватьПрочиеВзаимодействия";
		Команда.Важность = "СмТакже";
	КонецЕсли;
	
	Возврат Команда;
	
КонецФункции

// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытий

#КонецОбласти

#КонецЕсли
