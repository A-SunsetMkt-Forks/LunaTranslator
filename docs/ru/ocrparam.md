## Автоматизированный метод выполнения OCR

### Анализ обновления изображения

Этот метод использует параметры "Порог стабильности изображения", "Порог согласованности изображения" и "Порог сходства текста".

#### 1. Порог стабильности изображения

Когда текст игры не появляется сразу (скорость текста не самая высокая) или игра имеет динамическое фоновое изображение или live2d, захваченное изображение постоянно меняется.

При каждом захвате изображения оно сравнивается с предыдущим захватом, вычисляя степень сходства. Если степень сходства больше порогового значения, изображение считается стабильным и производится следующее определение.

Если можно утверждать, что игра полностью статична, этот параметр можно установить в 0, в противном случае его можно увеличить.

#### 2. Порог согласованности изображения

Этот параметр является наиболее важным.

После того как изображение стабилизируется, сравнивается текущее изображение с изображением, на котором была проведена OCR в последний раз (а не с предыдущим захватом). Если степень сходства меньше порогового значения, предполагается, что текст игры изменился и выполняется OCR.

Если частота OCR слишком высока, этот параметр можно увеличить; наоборот, если он слишком медленный, его можно уменьшить.

#### 3. Порог сходства текста

Результаты OCR не являются стабильными, часто малые изменения в изображении могут вызвать незначительные изменения в тексте, что, в свою очередь, приводит к повторному переводу.

После каждого вызова OCR результаты сравниваются с предыдущими результатами OCR (редакционное расстояние), и текст выводится только при превышении редакционного расстояния пороговым значением.

### Периодическое выполнение

Этот метод выполняется периодически с использованием "Порога сходства текста" для предотвращения перевода одинаковых текстов.

### Анализ обновления изображения + Периодическое выполнение

Кombining the two methods mentioned above, OCR is performed at least every "execution cycle" time interval, and the "text similarity threshold" is used to avoid translating the same text. Also, OCR is performed during the interval according to "image update analysis", and the OCR within the interval resets the interval timer.

### Триггер мыши и клавиатуры + Ожидание стабильности

#### 1. Событие триггера

По умолчанию следующие события мыши и клавиатуры активируют этот метод: нажатие левой кнопки мыши, нажатие клавиши Enter, отпускание клавиши Ctrl, отпускание клавиши Shift, отпускание клавиши Alt. Если окно игры привязано, метод активируется только тогда, когда окно игры находится в фокусе.

После активации этого метода, поскольку необходимо подождать, пока игра отрендерит новый текст или пока текст не появится сразу (скорость текста не самая высокая), необходимо немного подождать, пока отображаемый текст стабилизируется.

После активации этого метода и стабилизации будет выполнен перевод, без учета сходства текста.

Если скорость текста является максимальной, следующие два параметра можно установить в 0. В противном случае, для определения времени ожидания необходимы следующие параметры:

#### 2. Задержка (с)

Ждет фиксированное время задержки (встроенная задержка составляет 0,1 с для удовлетворения внутренней логики обработки игрового движка).

#### 3. Порог стабильности изображения

Этот параметр аналогичен вышеупомянутому с同名 параметру. Но он используется только для определения завершения рендеринга текста, поэтому не используется совместно с вышеупомянутым параметром.

Поскольку время рендеринга медленного текста нефиксированно, использование указанного фиксированного задержки может быть недостаточным. При выполнении данного триггерного события, когда степень сходства изображения с предыдущим захватом больше порогового значения.