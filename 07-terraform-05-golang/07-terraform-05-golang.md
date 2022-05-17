# Домашнее задание к занятию "7.5. Основы golang"

С `golang` в рамках курса, мы будем работать не много, поэтому можно использовать любой IDE. 
Но рекомендуем ознакомиться с [GoLand](https://www.jetbrains.com/ru-ru/go/).  

## Задача 1. Установите golang.
1. Воспользуйтесь инструкций с официального сайта: [https://golang.org/](https://golang.org/).
2. Так же для тестирования кода можно использовать песочницу: [https://play.golang.org/](https://play.golang.org/).

## Задача 2. Знакомство с gotour.
У Golang есть обучающая интерактивная консоль [https://tour.golang.org/](https://tour.golang.org/). 
Рекомендуется изучить максимальное количество примеров. В консоли уже написан необходимый код, 
осталось только с ним ознакомиться и поэкспериментировать как написано в инструкции в левой части экрана.  

## Задача 3. Написание кода. 
Цель этого задания закрепить знания о базовом синтаксисе языка. Можно использовать редактор кода 
на своем компьютере, либо использовать песочницу: [https://play.golang.org/](https://play.golang.org/).

1. Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные 
у пользователя, а можно статически задать в коде.
    Для взаимодействия с пользователем можно использовать функцию `Scanf`:
    ```
    package main
    
    import "fmt"
    
    func main() {
        fmt.Print("Enter a number: ")
        var input float64
        fmt.Scanf("%f", &input)
    
        output := input * 2
    
        fmt.Println(output)    
    }
    ```
 
### Ответ:
```
package main

import "fmt"

func main() {
    fmt.Print("Enter length in meters: ")
    var input float64
    fmt.Scanf("%f", &input)
    output := input / 0.3048
    fmt.Println("length in feet", output)
}
```


1. Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:
    ```
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
    ```
### Ответ:
```
package main

import (
    "fmt"
    . "sort"
)

func srch_min (x []int) int{
    var min int
    min = x[0]
    for i:=0; i<len(x);i++ {
        if x[i] < min {
            min = x[i]
        }
    }
    return min
}

func sort_min (x []int) int {
    Ints(x)
    return x[0]
}

func main() {
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
    fmt.Println("Min is",srch_min(x),"by srch_min")
    fmt.Println("Min is",sort_min(x),"by sort_min")
}
```

1. Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть `(3, 6, 9, …)`.

### Ответ:
```
package main

import "fmt"
// Реализация №1
func func1() {
    fmt.Println("func1:")
    var x int
    for i:=0;i<100;i++ {
        x = i+1
        if x % 3 == 0 {
            fmt.Println(x)
        }
    }
}
// Реализация №2
func func2() {
    fmt.Println("func2:")
    var x int = 0
    for x <= 100 {
        x = x + 3
        if x <= 100 {
            fmt.Println(x)
        }
    }
}

func main() {
    func1()
    func2()
}
```

В виде решения ссылку на код или сам код. 

## Задача 4. Протестировать код (не обязательно).

Создайте тесты для функций из предыдущего задания. 

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

