#Область ОписаниеПеременных

#КонецОбласти

#Область ОбработчикиСобытийФормы

// Код процедур и функций



#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	НаименованиеПриИзмененииНаСервере();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы //<ИмяТаблицыФормы>

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиКомандФормы

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура НаименованиеПриИзмененииНаСервере()
	
	ЧастиИмени = ФизическиеЛицаКлиентСервер.ЧастиИмени(СокрЛП(Объект.Наименование));
	Объект.Фамилия = ЧастиИмени.Фамилия;
	Объект.Имя = ЧастиИмени.Имя;
	Объект.Отчество = ЧастиИмени.Отчество;
		
КонецПроцедуры

#КонецОбласти
