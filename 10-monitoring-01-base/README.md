# Домашнее задание к занятию "10.01. Зачем и что нужно мониторить"

## Обязательные задания

1. Вас пригласили настроить мониторинг на проект. На онбординге вам рассказали, что проект представляет из себя 
платформу для вычислений с выдачей текстовых отчетов, которые сохраняются на диск. Взаимодействие с платформой 
осуществляется по протоколу http. Также вам отметили, что вычисления загружают ЦПУ. Какой минимальный набор метрик вы
выведите в мониторинг и почему?

    #### Ответ:

    - Среднюю загрузку CPU + iowait - т.к. вычисления загружают ЦП то в случае нехватки ЦП наша платформа будет работать медленнее.
    - Количество используемой оперативной памяти - если приложение будет потреблять больше памяти чем может предоставить система, то либо оно будет принудительно закрыто системой или будет использован swap (если мы его добавляли).
    - Длину очереди диска - т.к. мы записываем отчеты на диск, а возможно и вычитываем данные для формирования результатов отчета, нам необходимо понимание справляется ли наша текущая конфигурация требованиями платформы.
    - Размер свободного места на диске - при исчерпании свободного места на диске будет невозможна работа платформы (не сможет сохранят отчеты), но и вероятен отказ всей системы.
    - inodes - при наличии свободного места на диске, но при отсутствии свободных дескрипторов запись на диск так же не будет доступна.
    - код ответа http - один из признаков, что наша платформа жива
    - скорость загрузки отчета по http - параметр скорее относительный по которому можно понять наличии проблемы в загрузке канала/медленной работой других компонентов.
    - нагрузка на сеть - т.к. отдаем отчеты по сети мы должны понимать не упираемся ли мы в ширину канала при активной загрузке отчетов клиентами.



2. Менеджер продукта посмотрев на ваши метрики сказал, что ему непонятно что такое RAM/inodes/CPUla. Также он сказал, 
что хочет понимать, насколько мы выполняем свои обязанности перед клиентами и какое качество обслуживания. Что вы 
можете ему предложить?

    #### Ответ:

    1. Определить требования к характеристикам качественного предоставления услуг. (Время загрузка личного кабинета клиента/Время подготовки отчета/Время загрузки отчета/Время доступности системы и т.д.) - SLO и SLA
    2. Предоставить возможность мониторинга выполнения обязанностей перед клиентами путем расчета SLI и настройки уведомления в случае, если SLI отклонился от требуемых значение.


3. Вашей DevOps команде в этом году не выделили финансирование на построение системы сбора логов. Разработчики в свою 
очередь хотят видеть все ошибки, которые выдают их приложения. Какое решение вы можете предпринять в этой ситуации, 
чтобы разработчики получали ошибки приложения?

    #### Ответ:

    1. Совместно с разработчиками попытаться повлиять на выделение финансирования для создания системы сбора логов приводя существенные доводы о необходимости наличия данной системы.

    2. При наличии вычислительных мощностей в ЦОД можно развернуть систему сбора логов (ELK или аналог) с минимальными характеристиками, чтобы закрыть вопрос перед разработчиками до выделения финансирования.

    3. Воспользоваться одним из облачных сервисов по сбору/хранению логов в бесплатном варианте с существующими ограничения у вендора. Могут быть ограничения срок хранения/объем хранения/количество серверов (с которых сохраняются логи).



3. Вы, как опытный SRE, сделали мониторинг, куда вывели отображения выполнения SLA=99% по http кодам ответов. 
Вычисляете этот параметр по следующей формуле: summ_2xx_requests/summ_all_requests. Данный параметр не поднимается выше 
70%, но при этом в вашей системе нет кодов ответа 5xx и 4xx. Где у вас ошибка?

    #### Ответ:

    Ошибка в формуле расчета. Не учтены коды ответов 3хх.
    (sum_2xx_req+sum_3xx_req)/sum_all_req


