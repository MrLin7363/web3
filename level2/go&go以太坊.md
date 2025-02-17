文字教程 https://www.cainiaoplus.com/golang/golang-channel.html

# 一、go基础语法学习

## 1.  环境

安装教程 https://blog.csdn.net/qq_46027425/article/details/139924867

vscode安装三大插件

0.2.1.1 Go 插件

https://marketplace.visualstudio.com/items?itemName=golang.Go

0.2.1.2 Debugger 插件

https://marketplace.visualstudio.com/items?itemName=wowbox.code-debuger

注：虽然安装完 Go 插件之后，就可以 debug go 代码，但是如果启动 go 的 main 函数需要使用 args 传递参数时，实测使用这个插件，兼容性更好。

0.2.1.3 AI 辅助编码插件

https://marketplace.visualstudio.com/items?itemName=sourcegraph.cody-ai





配置系统变量

```
GOPATH    第一个用于放 Go 语言的第三方包，第二个用于放自己的开发代码
G:\software\go1.24\library;G:\software\go1.24\workplace

GOROOT
G:\software\go1.24\go

PATH
%GOROOT%\bin
```

配置代理

```
#开启mod模式（项目管理需要用到）
go env -w GO111MODULE=on
#重新设置成七牛镜像源（推荐）或阿里镜像源（用原有的会比较慢）
go env -w GOPROXY=https://goproxy.cn,direct
go env -w GOPROXY=https://mirrors.aliyun.com/goproxy

#关闭包的MD5校验
go env -w GOSUMDB=off

#查看环境变量
go env
————————————————

                            版权声明：本文为博主原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接和本声明。
                        
原文链接：https://blog.csdn.net/qq_46027425/article/details/139924867
```

vscode 添加lanuch.file

```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
    {
        "name": "Launch file",
        "type": "go",
        "request": "launch",
        "mode": "debug",
        "program": "${file}",
        "args": [
            "--test=flags"
        ]
    }
    ]
}
```

terminal 安装go 开发工具

```
go install github.com/go-delve/delve/cmd/dlv@latest
```



### 1.1 创建项目

创建go项目初始化，根目录，不然一些运行报错

```
go mod init
```

```
Error loading workspace: packages.Load error: err: exit status 1: stderr: go: cannot find main module, but found .git/config in G:\web3\web3github to create a module there, run: cd ..\..\.. && go mod init
```

### 1.2 包定义

同一目录下的Go文件，必须属于同一个package



一个go程序只能有一个main函数

main函数作为启动函数的入口



## 2. 基本数据类型

**整形**

int，int8，int16，int32，int64，uint，uint8，uint16，uint32，uint64，uintptr。

**浮点数**

float32，float64。

`float32` 是单精度浮点数，精确到小数点后 7 位。

`float64` 是双精度浮点数，可以精确到小数点后 15 位。

### **byte类型**

`byte` 是 `uint8` 的内置别名，可以把 `byte` 和 `uint8` 视为同一种类型。

在 Go 中，字符串可以直接被转换成 `[]byte`（byte 切片）。

```
var s string = "Hello, world!"
var bytes []byte = []byte(s)
fmt.Println("convert \"Hello, world!\" to bytes: ", bytes)
```



同时[]byte 也可以直接转换成 string。

```
var bytes []byte = []byte{72, 101, 108, 108, 111, 44, 32, 119, 111, 114, 108, 100, 33}
var s string = string(bytes)
fmt.Println(s)
```

### **rune类型**

`rune` 是 `int32` 的内置别名，可以把 `rune` 和 `int32` 视为同一种类型。但 rune 是特殊的整数类型。

在 Go 中，一个 rune 值表示一个 Unicode 码点。一般情况下，一个 Unicode 码点可以看做一个 Unicode 字符。有些比较特殊的 Unicode 字符有多个 Unicode 码点组成。

一个 rune 类型的值由一个个被单引号包住的字符组成，比如：

```
var r1 rune = 'a'
var r2 rune = '世'
```

字符串可以直接转换成 `[]rune`（rune 切片）。

```
var s string = "abc，你好，世界！"
var runes []rune = []rune(s)
```

**string**

**bool**

**零值**

## 3. 变量定义

### 全局变量

```
方式 1，完整的声明：
var <name> <type> = <value>

方式 2，仅声明，但未赋值，为类型默认零值：
var <name> <type>

方式 3， 不声明类型，但 Go 会根据表达式或字面量自动推导此变量的类型：
var <name> = <value>

方式 4，对全局变量分组声明：
// 声明多个时，可以用小括号包裹，此方式不限制声明次数
var (
  <name1> <type1> = <value1>
  <name2> <type2>
  <name3> = <value3>
)
```

### 局部变量

方式 1，与全局变量的声明方式完全一致：

```
var <name> <type> = <value>
```

方式 2，也是与全局变量声明方式完全相同，仅声明，为类型默认零值：

```
var <name> <type>
```

方式 3，无需关键字 var，也无需声明类型，Go 通过字面量或表达式推导此变量类型：

```
<name> := <value>
```

方式 4，这种方式是全局变量没有的，可以直接在返回值中声明，相当于在方法一开始就声明了这些变量：

```
func method() (<name1> <type1>, <name2> <type2>) {
    return
}

func method() (<name1> <type1>, <name2> <type2>) {
    return <value1>, <value2>
}
```

```
func method1() {
    // 方式1，类型推导，用得最多
    a := 1
    // 方式2，完整的变量声明写法
    var b int = 2
    // 方式3，仅声明变量，但是不赋值，
    var c int
    fmt.Println(a, b, c)
}

// 方式4，直接在返回值中声明
func method2() (a int, b string) {
    // 这种方式必须声明return关键字
    // 并且同样不需要使用，并且也不用必须给这种变量赋值
    return 1, "test"
}

func method3() (a int, b string) {
    a = 1
    b = "test"
    return
}

func method4() (a int, b string) {
    return
}
```

多变量

```
var a, b, c int = 1, 2, 3

var e, f, g int

var h, i, j = 1, 2, "test"

func method() {
    var k, l, m int = 1, 2, 3
    var n, o, p int
    q, r, s := 1, 2, "test"
    fmt.Println(k, l, m, n, o, p, q, r, s)
}
```

## 4. 指针

### 4.1 定义

一个指针变量指向了一个值的内存地址

```
var ip *int        /* 指向整型*/
var fp *float32    /* 指向浮点型 */
```

```
package main

import "fmt"

func main() {
   var a int= 20   /* 声明实际变量 */
   var ip *int        /* 声明指针变量 */

   ip = &a  /* 指针变量的存储地址 */

   fmt.Printf("a 变量的地址是: %x\n", &a  )

   /* 指针变量的存储地址 */
   fmt.Printf("ip 变量储存的指针地址: %x\n", ip )

   /* 使用指针访问值 */
   fmt.Printf("*ip 变量的值: %d\n", *ip )
}
```

### 4.2 空指针

```
package main

import "fmt"

func main() {
   var  ptr *int

   fmt.Printf("ptr 的值为 : %x\n", ptr  )
}
```

### 4.3 指针作为函数参数

```
package main

import "fmt"

func main() {
   /* 定义局部变量 */
   var a int = 100
   var b int= 200

   fmt.Printf("交换前 a 的值 : %d\n", a )
   fmt.Printf("交换前 b 的值 : %d\n", b )

   /* 调用函数用于交换值
   * &a 指向 a 变量的地址
   * &b 指向 b 变量的地址
   */
   swap(&a, &b);

   fmt.Printf("交换后 a 的值 : %d\n", a )
   fmt.Printf("交换后 b 的值 : %d\n", b )
}

func swap(x *int, y *int) {
   var temp int
   temp = *x    /* 保存 x 地址的值 */
   *x = *y      /* 将 y 赋值给 x */
   *y = temp    /* 将 temp 赋值给 y */
}
```

### 4.4 指针数组

```
package main

import "fmt"

const MAX int = 3

func main() {
   a := []int{10,100,200}
   var i int
   var ptr [MAX]*int;

   for  i = 0; i < MAX; i++ {
      ptr[i] = &a[i] /* 整数地址赋值给指针数组 */
   }

   for  i = 0; i < MAX; i++ {
      fmt.Printf("a[%d] = %d\n", i,*ptr[i] )
   }
}
```

### 4.5 指向指针的指针

```
package main

import "fmt"

func main() {

   var a int
   var ptr *int
   var pptr **int

   a = 3000

   /* 指针 ptr 地址 */
   ptr = &a

   /* 指向指针 ptr 地址 */
   pptr = &ptr

   /* 获取 pptr 的值 */
   fmt.Printf("变量 a = %d\n", a )
   fmt.Printf("指针变量 *ptr = %d\n", *ptr )
   fmt.Printf("指向指针的指针变量 **pptr = %d\n", **pptr)
}

```

## 5. 结构体

```
package main

import "fmt"

type Books struct {
   title string
   author string
   subject string
   book_id int
}


func main() {

    // 创建一个新的结构体
    fmt.Println(Books{"Go 语言", "www.runoob.com", "Go 语言教程", 6495407})

    // 也可以使用 key => value 格式
    fmt.Println(Books{title: "Go 语言", author: "www.runoob.com", subject: "Go 语言教程", book_id: 6495407})

    // 忽略的字段为 0 或 空
   fmt.Println(Books{title: "Go 语言", author: "www.runoob.com"})
}
```

访问

```
结构体.成员名"
```

### 5.1 嵌套结构体

```
//嵌套结构体 
package main 
  
import "fmt"
  
//创建结构体
type Author struct { 
    name   string 
    branch string 
    year   int
} 
  
//创建嵌套结构体
type HR struct { 
  
    //字段结构
    details Author 
} 
  
func main() { 
  
    // 初始化结构体字段 
    result := HR{       
        details: Author{"Sona", "ECE", 2013}, 
    } 
  
    //打印输出值
    fmt.Println("\n作者的详细信息") 
    fmt.Println(result) 
        fmt.Println("\n学生详细资料") 
    fmt.Println("学生的名字: ", result.details.name) 
}
```



### 5.2 匿名结构体

```
package main 
  
import "fmt"
  
//创建一个结构匿名字段 
type student struct { 
    int   // 不指定名称，访问直接value.int 类型   在结构中，不允许创建两个或多个相同类型的字段，如果要两个同类型则定义名称
    string 
    float64 
} 
  
// Main function 
func main() { 
  
    // 将值分配给匿名,学生结构的字段
    value := student{123, "Bud", 8900.23} 
  
    fmt.Println("入学人数 : ", value.int) 
    fmt.Println("学生姓名 : ", value.string) 
    fmt.Println("套餐价格 : ", value.float64) 
}
```

### 5.3 函数作为结构体字段

```
//作为Go结构中的字段
package main 
  
import "fmt"
  
// Finalsalary函数类型
type Finalsalary func(int, int) int
  
//创建结构
type Author struct { 
    name      string 
    language  string 
    Marticles int
    Pay       int
  
    //函数作为字段
    salary Finalsalary 
} 
  
func main() { 
  
    // 初始化字段结构
    result := Author{ 
        name:      "Sonia", 
        language:  "Java", 
        Marticles: 120, 
        Pay:       500, 
        salary: func(Ma int, pay int) int { 
            return Ma * pay 
        }, 
    } 
  
    fmt.Println("作者姓名: ", result.name) 
    fmt.Println("语言: ", result.language) 
    fmt.Println("五月份发表的文章总数: ", result.Marticles) 
    fmt.Println("每篇报酬: ", result.Pay) 
    fmt.Println("总工资: ", result.salary(result.Marticles, result.Pay)) 
}
```



## 6. 变量和枚举

```
// 方式1
const a int = 1

// 方式2
const b = "test"

// 方式3
const c, d = 2, "hello"

// 方式4
const e, f bool = true, false

// 方式5
const (
    h    byte = 3
    i         = "value"
    j, k      = "v", 4
    l, m      = 5, false
)

const (
    n = 6
)
```

：Go 中，**常量只能使用基本数据类型**，即数字、字符串和布尔类型。不能使用复杂的数据结构，比如切片、数组、map、指针和结构体等。如果使用了非基本数据类型，会在编译期报错。



枚举

```
const (
    Male = "Male"
    Female = "Female"
)
```

## 7. 数组

```
func main() {
    a := [5]int{5, 4, 3, 2, 1}

    // 方式1，使用下标读取数据
    element := a[2]
    fmt.Println("element = ", element)

    // 方式2，使用range遍历
    for i, v := range a {
        fmt.Println("index = ", i, "value = ", v)
    }

    for i := range a {
        fmt.Println("only index, index = ", i)
    }

    // 读取数组长度
    fmt.Println("len(a) = ", len(a))
    // 使用下标，for循环遍历数组
    for i := 0; i < len(a); i++ {
        fmt.Println("use len(), index = ", i, "value = ", a[i])
    }
}
```

```
func main() {
    // 二维数组
    a := [3][2]int{
        {0, 1},
        {2, 3},
        {4, 5},
    }
    fmt.Println("a = ", a)

    // 三维数组
    b := [3][2][2]int{
        {{0, 1}, {2, 3}},
        {{4, 5}, {6, 7}},
        {{8, 9}, {10, 11}},
    }
    fmt.Println("b = ", b)

    // 也可以省略各个位置的初始化,在后续代码中赋值
    c := [3][3][3]int{}
    c[2][2][1] = 5
    c[1][2][1] = 4
    fmt.Println("c = ", c)
}
```

## 8. 切片

切片(Slice)并不是数组或者数组指针，而是数组的一个引用，

切片本身是一个标准库中实现的一个特殊的结构体，这个结构体中有三个属性，分别代表数组指针、长度、容量。

```
// 方式1，声明并初始化一个空的切片
var s1 []int = []int{}

// 方式2，类型推导，并初始化一个空的切片
var s2 = []int{}

// 方式3，与方式2等价
s3 := []int{}

// 方式4，与方式1、2、3 等价，可以在大括号中定义切片初始元素
s4 := []int{1, 2, 3, 4}

// 方式5，用make()函数创建切片，创建[]int类型的切片，指定切片初始长度为0
s5 := make([]int, 0)

// 方式6，用make()函数创建切片，创建[]int类型的切片，指定切片初始长度为2，指定容量参数4
s6 := make([]int, 2, 4) 

// 方式7，引用一个数组，初始化切片
a := [5]int{6,5,4,3,2}
// 从数组下标2开始，直到数组的最后一个元素
s7 := arr[2:]
// 从数组下标1开始，直到数组下标3的元素，创建一个新的切片
s8 := arr[1:3]
// 从0到下标2的元素，创建一个新的切片
s9 := arr[:2]
```

## 9. map

```
方式 1，仅声明 map：

方式 2，使用内置函数 make() 初始化：

方式 3，在初始化时，同时插入键值对：



import (
	"fmt"
	"sync"
	"time"
)

func main() {
	// 1.var声明
	var m1 map[string]string
	fmt.Println("m1 length:", len(m1))

	// 2.内置函数初始化
	m2 := make(map[string]string)
	fmt.Println("m2 length:", len(m2))
	fmt.Println("m2 =", m2)

	// 3. 指定容量，避免扩容
	m3 := make(map[string]string, 10)
	fmt.Println("m3 length:", len(m3))
	fmt.Println("m3 =", m3)

	// 4. 直接初始化
	m4 := map[string]string{}
	fmt.Println("m4 length:", len(m4))
	fmt.Println("m4 =", m4)

	// 5. 直接初始化,包括数据
	m5 := map[string]string{
		"key1": "value1",
		"key2": "value2",
	}
	fmt.Println("m5 length:", len(m5))
	fmt.Println("m5 =", m5)

	second()
}

func second() {
	m := make(map[string]int, 10)

	m["1"] = int(1)
	m["2"] = int(2)
	m["3"] = int(3)
	m["4"] = int(4)
	m["5"] = int(5)
	m["6"] = int(6)

	// 获取元素
	value1 := m["1"]
	fmt.Println("m[\"1\"] =", value1)

	// 值，是否存在key
	value1, exist := m["1"]
	fmt.Println("m[\"1\"] =", value1, ", exist =", exist)

	valueUnexist, exist := m["10"]
	fmt.Println("m[\"10\"] =", valueUnexist, ", exist =", exist)

	// 修改值
	fmt.Println("before modify, m[\"2\"] =", m["2"])
	m["2"] = 20
	fmt.Println("after modify, m[\"2\"] =", m["2"])

	// 获取map的长度
	fmt.Println("before add, len(m) =", len(m))
	m["10"] = 10
	fmt.Println("after add, len(m) =", len(m))

	// 遍历map集合main
	for key, value := range m {
		fmt.Println("iterate map, m[", key, "] =", value)
	}

	// 使用内置函数删除指定的key
	_, exist_10 := m["10"]
	fmt.Println("before delete, exist 10: ", exist_10)
	delete(m, "10")
	_, exist_10 = m["10"]
	fmt.Println("after delete, exist 10: ", exist_10)

	// 在遍历时，删除map中的key
	for key := range m {
		fmt.Println("iterate map, will delete key:", key)
		delete(m, key)
	}
	fmt.Println("m = ", m)

	// map作为参数
	receiveMap(m)
}

func receiveMap(param map[string]int) {
	fmt.Println("before modify, in receiveMap func: param[\"a\"] = ", param["a"])
	param["a"] = 2
	param["b"] = 3
	bingfa()
}
```



### 9.2 并发使用map集合 

读写 ，写写都会报错

```
func main() {
    m := make(map[string]int)
    var wg sync.WaitGroup
    var lock sync.Mutex
    wg.Add(2)

    go func() {
        for {
            lock.Lock()
            m["a"]++
            lock.Unlock()
        }
    }()

    go func() {
        for {
            lock.Lock()
            m["a"]++
            fmt.Println(m["a"])
            lock.Unlock()
        }
    }()

    select {
    case <-time.After(time.Second * 5):
        fmt.Println("timeout, stopping")
    }
}
```



## 10. goroutine

goroutine 是轻量线程，创建一个 goroutine 所需的资源开销很小，所以可以创建非常多的 goroutine 来并发工作。

它们是由 Go 运行时调度的。调度过程就是 Go 运行时把 goroutine 任务分配给 CPU 执行的过程。

但是 goroutine 不是通常理解的线程，线程是操作系统调度的。

```
package main

import (
    "fmt"
    "time"
)

func say(s string) {
    for i := 0; i < 5; i++ {
        time.Sleep(100 * time.Millisecond)
        fmt.Println(s)
    }
}

// 多线程 debug程序不会打印东西  
// 使用命令行才行 go run main.go
func main() {
    go func() {
        fmt.Println("run goroutine in closure")
    }()
    go func(s string) {
		 fmt.Println(s)
    }("gorouine: closure params")

    go say("in goroutine: world")
    say("hello")
}
```

```
package main

import (
	"fmt"
	"sync"
	"time"
)

// 线程安全的计数器
type SafeCounter struct {
	mu    sync.Mutex
	count int
}

// 增加计数
func (c *SafeCounter) Increment() {
	c.mu.Lock()
	defer c.mu.Unlock()
	c.count++
}

// 获取当前计数
func (c *SafeCounter) GetCount() int {
	c.mu.Lock()
	defer c.mu.Unlock()
	return c.count
}

type UnsafeCounter struct {
	count int
}

// 增加计数
func (c *UnsafeCounter) Increment() {
	c.count += 1
}

// 获取当前计数
func (c *UnsafeCounter) GetCount() int {
	return c.count
}

// 多线程 debug程序不会打印东西  
// 使用命令行才行 go run main.go
func main() {
	fmt.Printf("Final count: %d\n")
	counter := SafeCounter{}

	// 启动100个goroutine同时增加计数
	for i := 0; i < 1000; i++ {
		go func() {
			for j := 0; j < 100; j++ {
				counter.Increment()
			}
		}()
	}

	// 等待一段时间确保所有goroutine完成
	time.Sleep(time.Second)

	// 输出最终计数
	fmt.Printf("Final count: %d\n", counter.GetCount())
}

```

## 11. channel

channel 是 Go 中定义的一种类型，专门用来在多个 goroutine 之间通信的线程安全的数据结构。

可以在一个 goroutine 中向一个 channel 中发送数据，从另外一个 goroutine 中接收数据。

channel 类似队列，满足先进先出原则。

**关键字 chan**

```
// 仅声明
var <channel_name> chan <type_name>

// 初始化
<channel_name> := make(chan <type_name>)

// 初始化有缓冲的channel
<channel_name> := make(chan <type_name>, 3)
```



channel 的三种操作：发送数据，接收数据，以及关闭通道。

声明方式：

```
// 发送数据
channel_name <- variable_name_or_value

// 接收数据
value_name, ok_flag := <- channel_name
value_name := <- channel_name

// 关闭channel
close(channel_name)
```



channel 还有两个变种，可以把 channel 作为参数传递时，限制 channel 在函数或方法中能够执行的操作。

声明方式：

```
//仅发送数据
func <method_name>(<channel_name> chan <- <type>)

//仅接收数据
func <method_name>(<channel_name> <-chan <type>)
```



代码示例：

```
package main

import (
	"fmt"
	"time"
)

// 只接收channel的函数
func receiveOnly(ch <-chan int) {
	for v := range ch {
		fmt.Printf("接收到: %d\n", v)
	}
}

// 只发送channel的函数
func sendOnly(ch chan<- int) {
	for i := 0; i < 5; i++ {
		// 发送i到channel
		ch <- i
		fmt.Printf("发送: %d\n", i)
		time.Sleep(500 * time.Millisecond)
	}
	close(ch)
}

func main() {
	// 创建一个带缓冲的channel
	// 如果3满了才会阻塞
	ch := make(chan int, 3)

	// 启动发送goroutine
	go sendOnly(ch)

	// 启动接收goroutine
	go receiveOnly(ch)

	// 使用select进行多路复用,主线程设置5秒结束
	timeout := time.After(5 * time.Second)
	for {
		select {
		case v, ok := <-ch:
			if !ok {
				fmt.Println("Channel已关闭")
				return
			}
			fmt.Printf("主goroutine接收到: %d\n", v)
		case <-timeout:
			fmt.Println("操作超时")
			return
		default:
			fmt.Println("没有数据，等待中...")
			time.Sleep(500 * time.Millisecond)
		}
	}
}

```

**锁与 channel**

在 Go 中，当需要 goroutine 之间协作地方，更常见的方式是使用 channel，而不是 sync 包中的 Mutex 或 RWMutex 的互斥锁。但其实它们各有侧重。

大部分时候，流程是根据数据驱动的，channel 会被使用得更频繁。

channel 擅长的是**数据流动的场景**：

1. 传递数据的所有权，即把某个数据发送给其他协程。
2. 分发任务，每个任务都是一个数据。
3. 交流异步结果，结果是一个数据。

而锁使用的场景更偏向**同一时间只给一个协程访问数据的权限**：

1. 访问缓存
2. 管理状态



## 12. select

select 语义是和 channel 绑定在一起使用的，select 可以实现从多个 channel 收发数据，可以使得一个 goroutine 就可以处理多个 channel 的通信。

语法上和 switch 类似，有 case 分支和 default 分支，只不过 select 的每个 case 后面跟的是 channel 的收发操作。

定义方式：

```
select {
case channel_name <- varaible_name_or_value: // send data to channel  case var_name = <-ch2 : 
											// receive data from channeldo sthcase data, ok := <-ch3:
 
case value_name, ok_flag := <- channel_name:
    do sth
default:
    do sth
}
```

语法上和switch的一些区别：

- select 关键字和后面的 `{` 之间，不能有表达式或者语句。
- 每个 case 关键字后面跟的必须是 channel 的发送或者接收操作
- 允许多个 case 分支使用相同的 channel，case 分支后的语句甚至可以重复

```
package main

import (
	"fmt"
)

func main() {
	ch1 := make(chan int, 10)
	ch2 := make(chan int, 10)
	ch3 := make(chan int, 10)
	go func() {
		for i := 0; i < 10; i++ {
			ch1 <- i
			ch2 <- i
			ch3 <- i
		}
	}()
	for i := 0; i < 10; i++ {
		select {
		case x := <-ch1:
			fmt.Printf("receive %d from channel 1\n", x)
		case y := <-ch2:
			fmt.Printf("receive %d from channel 2\n", y)
		case z := <-ch3:
			fmt.Printf("receive %d from channel 3\n", z)
		}
	}
}

```

在执行 select 语句的时候，如果当下那个时间点没有一个 case 满足条件，就会走 default 分支。

至多只能有一个 default 分支。

如果没有 default 分支，select 语句就会阻塞，直到某一个 case 满足条件。

如果 select 里任何 case 和 default 分支都没有，就会一直阻塞。

如果多个 case 同时满足，select 会随机选一个 case 执行。

## 13. range 



### 遍历一维数组和一维切片

```
package main

import "fmt"

func main() {
    array := [...]int{1, 2, 3}
    slice := []int{4, 5, 6}

    // 方法1：只拿到数组的下标索引
    for index := range array {
        fmt.Printf("array -- index=%d value=%d \n", index, array[index])
    }
    for index := range slice {
        fmt.Printf("slice -- index=%d value=%d \n", index, slice[index])
    }
    fmt.Println()

    // 方法2：同时拿到数组的下标索引和对应的值
    for index, value := range array {
        fmt.Printf("array -- index=%d index value=%d \n", index, array[index])
        fmt.Printf("array -- index=%d range value=%d \n", index, value)
    }
    for index, value := range slice {
        fmt.Printf("slice -- index=%d index value=%d \n", index, slice[index])
        fmt.Printf("slice -- index=%d range value=%d \n", index, value)
    }
    fmt.Println()
}
```

### 遍历二维数组与切片：

```
package main

import (
    "fmt"
    "reflect"
)

func main() {
    array := [...][3]int{{1, 2, 3}, {4, 5, 6}}
    slice := [][]int{{1, 2}, {3}}
    // 只拿到行的索引
    for index := range array {
        // array[index]类型是一维数组
        fmt.Println(reflect.TypeOf(array[index]))
        fmt.Printf("array -- index=%d, value=%v\n", index, array[index])
    }

    for index := range slice {
        // slice[index]类型是一维数组
        fmt.Println(reflect.TypeOf(slice[index]))
        fmt.Printf("slice -- index=%d, value=%v\n", index, slice[index])
    }

    // 拿到行索引和该行的数据
    fmt.Println("print array element")
    for row_index, row_value := range array {
        fmt.Println(row_index, reflect.TypeOf(row_value), row_value)
    }

    fmt.Println("print array slice")
    for row_index, row_value := range slice {
        fmt.Println(row_index, reflect.TypeOf(row_value), row_value)
    }

    // 双重遍历，拿到每个元素的值
    for row_index, row_value := range array {
        for col_index, col_value := range row_value {
            fmt.Printf("array[%d][%d]=%d ", row_index, col_index, col_value)
        }
        fmt.Println()
    }
    for row_index, row_value := range slice {
        for col_index, col_value := range row_value {
            fmt.Printf("slice[%d][%d]=%d ", row_index, col_index, col_value)
        }
        fmt.Println()
    }
}
```

### 遍历channel

通道除了可以使用 for 循环配合 select 关键字获取数据以外，也可以使用 for 循环配合 range 关键字获取数据。

因为通道结构的特殊性，当使用 range 遍历通道时，只给一个迭代变量赋值，而不像数组或字符串一样能够使用 index 索引。

当通道被关闭时，在 range 关键字迭代完通道中所有值后，循环就会自动退出。

```

package main

import (
    "fmt"
    "time"
)

func addData(ch chan int) {
    size := cap(ch)
    for i := 0; i < size; i++ {
        ch <- i
        time.Sleep(1 * time.Second)
    }
    close(ch)
}

func main() {
    ch := make(chan int, 10)

    go addData(ch)

    for i := range ch {
        fmt.Println(i)
    }
}
```

### 对map映射

```
package main

import "fmt"

func main() {
    hash := map[string]int{
        "a": 1,
        "f": 2,
        "z": 3,
        "c": 4,
    }

    for key := range hash {
        fmt.Printf("key=%s, value=%d\n", key, hash[key])
    }

    for key, value := range hash {
        fmt.Printf("key=%s, value=%d\n", key, value)
    }
}
```

## 14. 函数

函数只有三个主要部分，分别是名称、参数列表、返回类型列表。

其中名称是必须的，参数列表和返回类型列表是可选的，也就是说函数可以没有参数，也没有返回值。

定义方式：

```
func <function_name>(<parameter list>) (<return types>) {
    <expressions>
    ...
}
```

代码示例：

```
func custom() {
    fmt.Println("Hello, world!")
}
```

## 15. 闭包

```
type A struct {
    i int
}

func (a *A) add(v int) int {
    a.i += v
    return a.i
}

// 声明函数变量
var function1 func(int) int

// 声明闭包
var squart2 func(int) int = func(p int) int {
    p *= p
    return p
}

func main() {
    a := A{1}
    // 把方法赋值给函数变量
    function1 = a.add
    
    // 声明一个闭包并直接执行
    // 此闭包返回值是另外一个闭包（带参闭包）
    returnFunc := func() func(int, string) (int, string) {
        fmt.Println("this is a anonymous function")
        return func(i int, s string) (int, string) {
            return i, s
        }
    }()

    // 执行returnFunc闭包并传递参数
    ret1, ret2 := returnFunc(1, "test")
    fmt.Println("call closure function, return1 = ", ret1, "; return2 = ", ret2)

    fmt.Println("a.i = ", a.i)
    fmt.Println("after call function1, a.i = ", function1(1))
    fmt.Println("a.i = ", a.i)
}
```

## 16. 方法&函数变量

与函数相比，方法是一个包含接受者的函数，大部分情况下可以通过类型的实例调用。

也可以把方法赋值给一个函数变量，使用函数变量调用这个方法，调用方式类似闭包。

```
type A struct {
    i int
}

// 定义方法
func (a *A) add(v int) int {
    a.i += v
    return a.i
}

// 声明函数变量
var function func(int) int

func main() {
    a := A{1}
    function = a.add

    fmt.Println("after call function, a.i = ", function(1))
    fmt.Println("a.i = ", a.i)
}
```





























# 二、Gin框架

中文教程1  https://www.topgoer.com/gin%E6%A1%86%E6%9E%B6/gin%E6%95%B0%E6%8D%AE%E8%A7%A3%E6%9E%90%E5%92%8C%E7%BB%91%E5%AE%9A/json%E6%95%B0%E6%8D%AE%E8%A7%A3%E6%9E%90%E5%92%8C%E7%BB%91%E5%AE%9A.html

安装go

```
 go get -u github.com/gin-gonic/gin
```

go run main.go

```
package main

import (
"net/http"
"time"

	"github.com/gin-gonic/gin"
)

func main() {
// 创建一个默认的路由引擎
r := gin.Default()

	// 定义一个 GET 接口，路径为 "/current-time"
	r.GET("/current-time", func(c *gin.Context) {
		// 获取当前时间
		currentTime := time.Now().Format("2006-01-02 15:04:05") // 格式化为 YYYY-MM-DD HH:MM:SS

		// 返回 JSON 响应
		c.JSON(http.StatusOK, gin.H{
			"time": currentTime,
		})
	})

	// 启动服务，默认在 0.0.0.0:8080 启动服务
	r.Run()

}
```

访问   http://localhost:8080/
