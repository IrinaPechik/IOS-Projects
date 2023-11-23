# Задания, выполненные в рамках курса по выбору "Основы IOS разработки"
## HW#2 Работа с Auto-layout и простыми представлениями UIKit
* У приложения нет Main storyboard-а и оно успешно собирается,
* При запуске приложения показывается WishMakerViewController,
* WishMakerViewController содержит приветственный заголовок и описание,
* Создан кастомный слайдер,
* Кастомный слайдер изменяет цвет фона,
* Код не содержит магических чисел,
* Слайдеры изменения цвета могут быть спрятаны или показаны снова по нажатию кнопки,
* 3 или более способов изменения цвета фона
### Ответы на вопросы
  * **Какие проблемы мешают нам использовать storyboard в реальных проектах?**
      1. Storyboard - это XML-файл, в нём тяжело править конфликты при слиянии изменений
      2. Storyboards менее гибкие, в отличие от кода
      3. Storyboards хрупкие, ошибка может привести к падению приложения на этапе выполнения
         
  * **wishTitle.translatesAutoresizingMaskIntoConstraints = false** - отключаем автоматическое создание constraints, т.к. система автоматически создает constraints на основе кадра представления и его маски.
    **view.addSubview(wishTitle)** - добавляем wishTitle к родительскому View
    
  * **Safe area layout guide** - это область экрана, в которой гарантировано отсутствие элементов пользовательского интерфейса, таких как полоса статуса, навигационная панель
    
  * **[weak self]** - это способ избежать зацикливания при использовании замыкания. Использование [weak self] гарантирует, что объект self не будет удерживаться в памяти только из-за замыкания.

  * **clipsToBounds** - это свойство, которое определяет, будет ли видно содержимое вью за ее границами. Если свойство установлено в true, то содержимое вью будет обрезано по ее границам. Если свойство установлено в false, то содержимое вью будет видно за ее границами.
    То есть в **stack.clipsToBounds = true** все подслои стека, выходящие за границы его рамок, будут обрезаны.

  * **var valueChanged: ((Double) -> Void)?** - переменная типа замыкания, которая вызывается при изменении значения слйдера, принимает double и ничего не возвращает

## HW#3 Работа с табличным представлением и User Defaults
#### Тема: Реализация фичи для записи желаний.

#### Цель: Отточить навыки работы с table view, попрактиковаться в хранении простой информации в User Defaults.

### Выполенные требования
* При запуске WishMakerViewController отображается кнопка для записи
желаний
* При нажатии на кнопку отображается новый WishStoringViewController
* WishStoringViewController содержит table view
* У таблицы есть ячейки
* Ячейки различаются по двум категориям: AddWishCell и WrittenWishCell.
* Желания, созданные через AddWishesCell добавляются в лист записанных желаний
* Записанные в таблицу желания сохраняются в UserDefaults и отображаются при перезапуске приложения.
* Записанные желания могут быть удалены, путем смахивания ячейки влево
* Записанные желания могут быть отредактированы, путем смахивания ячейки влево
