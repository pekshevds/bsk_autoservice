///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Вызывается перед открытием формы отправки SMS.
//
// Параметры:
//  НомераПолучателей - Массив из Структура:
//   * Телефон - Строка - номер получателя в формате +<КодСтраны><КодDEF><номер>;
//   * Представление - Строка - представление номера телефона;
//   * ИсточникКонтактнойИнформации - СправочникСсылка - владелец номера телефона.
//  
//  Текст - Строка - текст сообщения, длиной не более 1000 символов.
//  
//  ДополнительныеПараметры - Структура - дополнительные параметры отправки SMS:
//   * ИмяОтправителя - Строка - имя отправителя, которое будет отображаться вместо номера у получателей;
//   * ПеревестиВТранслит - Булево - Истина, если требуется переводить текст сообщения в транслит перед отправкой.
//
//  СтандартнаяОбработка - Булево -  флаг необходимости выполнения стандартной обработки отправки SMS.
//
Процедура ПриОтправкеSMS(НомераПолучателей, Текст, ДополнительныеПараметры, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Определяет адрес страницы провайдера в сети Интернет.
//
// Параметры:
//  Провайдер - ПеречислениеСсылка.ПровайдерыSMS - поставщик услуги по отправке SMS.
//  АдресВИнтернете - Строка - адрес страницы провайдера в Интернете.
//
Процедура ПриПолученииАдресаПровайдераВИнтернете(Провайдер, АдресВИнтернете) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти
