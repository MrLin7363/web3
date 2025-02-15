solidity/Foundry/web3

## 一，基础语法

### 1. 合约

```
pragma solidity 0.8.17;

//定义了一个名为"Book"的合约
contract Book { }

//在同一个.sol文件下可以定义多个合约，且他们都使用同一个编译器版本
contract Student { }
```

### 2. 数据类型

#### 2.1 值类型

值类型包含有：

- 布尔类型（Booleans）

- 整型（Integers）

- 定长浮点型（Fixed Point Numbers）

- 定长字节数组（Fixed-size byte arrays）

- 有理数和整型常量（Rational and Integer Literals)

- 字符串常量（String literals）

- 十六进制常量（Hexadecimal literals）

- 枚举（Enums）

- 函数类型（Function Types）

- 地址类型（Address)

- 地址常量（Address Literals）

  

### 2. 变量

```
pragma solidity ^0.8.7;
contract Book {

  //这是一个类型为int的变量，并将其初始化为10
  int basic_price = 10;

}
```

#### 无符号int

```
//使用关键字uint来定义无符号整型，int定义有符号整型
int ourInteger = -10;
uint outUInt = 1;

//更新整数的常用操作是 += 和 -=
int a = 3;
//这与 a = a + 3 相同，首先检索 a 的值，将其加上 3，然后将其分配回 a
a += 3; //a 现在是 6 
a -= 4; //同理，这与 a = a - 4 相同，a 现在是 2 

//我们还可以比较两个数字并返回一个 bool值。
//比较运算符有： <=， <， ==， !=， >=， > 。
bool d = 10 > 3; // 因为 10>3，所以 d 将为 true
bool e = 3 <= 3; // e 也将为 true，<= 表示小于等于
```

#### bit

值得注意的是，位数必须是 8 的倍数。

```solidity
1uint8 a;
2int256 b;
3int128 c;
4uint127 d; //这不是有效的，因为127不是8的倍数。
```

#### bool

```
contract Book {
    bool a = true;
    bool b = false;
    //逻辑非
    bool c = !a; // 此处c为false，我们对a的值进行了逻辑非操作，并将其赋值给 c
    bool d = !c; // 同理，d此处为true
```

### 3. 函数

#### function

```
//一个名为sum的函数
function sum() {
	//函数体
}


```

#### 公共变量和公共函数

```
contract A {
  //aa 和 bb 函数，以及 a 变量可以从任何地方访问，因为它们是 public 。
	//b 和 bbb只能从合约内部访问，因为它们是 private 。
	uint public a;
	uint private b;
	function aa() public {
		//这与a = a + 1 等同;
		a++;
	}
	function bb() public {
		b++;
	}
  function bbb() private {
    b++;
  }
}
```



#### internal 

只能合约内部访问

```

contract A {

    uint public result;

    function aa(uint a) internal {
        result = a + 1;
    }

    function b(uint b) public {
         aa(b);
    }
}
```

#### external

定义一个外部用户或其他合约能使用的*函数*，我们使用关键字 external，并将其放在*函数* 参数之后。

💡在本合约中使用时必须加上this关键词。

```
contract A {

    uint public result;

    function aa(uint a) external {
        result = a + 1;
    }

    function b(uint b) public {
         this.aa(b);
    }
}
```

```
function myFunction(uint temp, uint time) public { }
```

```
function add(int a, int b) public returns(int) {
		return a + b;
	}
```



#### 返回值

```
function test() public returns(bool) { }
```

**返回多个值**

```solidity
	// 定义一个名为 add 的公共函数，接收两个整型参数 a 和 b，并返回它们的和
5    function add(int a, int b) public returns(int) {
6				return a + b;
7    }
8		// 定义一个名为 addUp 的公共函数，接收三个整型参数 a、b 和 c，并返回它们的和
9    function addUp(int a, int b, int c) public returns(int) {
10        // 调用 add 函数将 a 和 b 相加，将结果保存在变量 d 中
11        int d = add(a, b);
12				// 调用 add 函数将 d 和 c 相加，将结果作为 addUp 函数的返回值返回
13        return add(d, c);
14    }
15
16
17    // 定义一个名为 addMul 的公共函数，接收两个整型参数 a 和 b，并返回它们的和与积
18    function addMul(int a, int b) public returns(int, int) {
19				return (a + b, a * b);
20    }
21		// 定义一个名为 addMulUp 的公共函数，接收三个整型参数 a、b 和 c，返回两个整数类型的值，分别为a+b+c, (a+b)*c
22    function addMulUp(int a, int b, int c) public returns(int, int) {
23        (int d,int e) = addMul(a, b);
24        return addMul(d, c);
25    }
```

### 4. 简单修饰符 

#### 状态变量-重要

状态变量是一种永久存在于区块链上的变量。

例如，假设你有一个[智能合约](https://www.hackquest.io/dd5c763aba0d47a387c24f8d8952ee97)，用于跟踪网站上的按钮被点击的次数。你可以创建一个名为 **clickCount** 的状态变量，它从零开始，每次有人点击该按钮时，其值增加*1*。

任何与合约交互的人都可以通过该状态变量来查询该按钮被点击了多少次。

如果这个信息应该被记录在区块链上，则将其设置为状态变量。

状态变量的通常需要更多的 gas 来读写，所以应当仅在必要时使用。

```
contract ContractName {
		//这是一个状态变量
    int a;  // 读取需要燃油费

		function add(int b) returns(int) {
			//b被定义为函数的输入参数，所以它不是状态变量
			//c是在函数中定义的，所以它也不是状态变量
			int c = a + b;	
			return c;
		}
}
```

**局部变量**=方法内部变量



#### pure函数

为了保持一致性，我们建议遵循此顺序：函数名称 、参数、作用域、状态可变性、返回值。

```solidity
function add() public pure {
	//function body 
}
```



**pure**，所谓纯函数就是该函数不会访问以及修改任何状态变量

```
contract Example {
    mapping(int => int) aa;
		//这是一个pure函数，不会访问aa状态变量数组
    function add(int a, int b) public pure returns(int) {
        return a + b;
   }
		//这不是一个pure函数
   function addNotPure(int a, int b) public returns(int) {
       aa[0] = a + b;
       return aa[0];
   }
}
```

#### view函数

一个 *view* 函数可以读取状态变量，但不能修改它

例如，假设你想知道你银行账户的余额，你会向银行发送一个查询请求，并等待收到响应。在这个过程中，你只是读取了你的账户余额信息，但没有修改它。

如果某个函数告诉你某些信息，但不对区块链进行任何更改，那么它就是一个 *view* 函数。



```
function add() public view {
	//function body 
}
```



### 5. 地址类型

#### address

address类型的to来表示要转账的接收方地址

```solidity
//定义
2address address1 = 0x35701d003AF0e05D539c6c71bF9421728426b8A0;
3
4//在以太坊中，每个地址都有一个成员变量，即地址的余额balance
5//余额以 uint 形式存在，因为它永远不可能为负值
6uint balance = address1.balance;
```

地址占20个字节，一个字节有8个 bit ,所以地址共有160个 *bit*，一个字节需要两个十六进制数表示，所以需要40个十六进制数表示一个地址。





#### 地址

*地址*分为两类：账户地址或合约地址。

**账户地址**

它是由用户创建的用于接收或发送资金的*地址*，由用户控制，也称为钱包。如果你不熟悉此概念，请参考 Metamask 。

**合约地址**

与“账户地址”相反，“合约地址”由合约（程序）控制。将*合约*放在以太坊上时，系统会为它生成一个独特的地址。其他人通过这个地址与合约进行交互。



#### address payable

**转移资金**（ETH）。

在 Solidity 中，只能对申明为 payable 的地址进行转账

如果我们想要从自己的账户向该账户转移资金，那么我们应该将其标记为address payable。

address payable receiver;
receiver.transfer(amount);

```
pragma solidity ^0.8.0;

contract AddressArray {
  address payable add = payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4); //显示转换
	address b = add; //隐式转换
	uint balance = b.balance; //获取b的余额
	function trans() public payable{
		//这将从当前合约向地址b转移10 Wei
		add.transfer(10);
	}
}
```

### 6. 映射类型mapping



单向关联

提供了一种以**结构化**方式存储和管理信息的方法。

想象你是一家银行。你需要跟踪所有账户（地址）的余额（整数）。

很多时候，你可以查找给定帐户的余额，但你不能查找给定余额的账户。这是一种单向关联。

mapping 提供了两个类型之间的单向关联 —— 在这里，一个是地址，一个是 uint。



```solidity
mapping(address => uint) balance;
```

在这里，地址称为键（ key ），uint 是值（ value ）。我们可以通过键查询值，不能通过值查询键。

```solidity
pragma solidity ^0.8.4;
2
3contract book {
4	//声明一个mapping，名称为owned_book，将地址映射到 uint 类型的值;
5	mapping(address => uint) public owned_book;
6}
```

##### 添加与更新

```solidity**
contract book {
4	//声明一个私有映射，将地址映射到一个 uint 值，表示该地址拥有的书籍ID
5	mapping(address => uint) private owned_book;
6	//声明一个名为 "add_book" 的函数，它接受一个 uint 类型的 bookID 作为输入，并且是公开可访问的
7	function add_book(uint bookID) public {
8		//将书籍ID添加到映射中，使用硬编码的地址 0x123 作为键
9		owned_book[address(0x123)] = bookID;
10	}
11}
```

```solidity
mapping(uint => bool) public myMapping;  // uint是建类型，bool是值类型
```

##### 查找

```solidity
contract book {
4	mapping(address => uint) private owned_book;
5
6	function add_book(address owner, uint bookID) public {
7		owned_book[owner] = bookID;
8	}
9	//获取书籍函数，根据地址获取对应的书籍 ID
10	function get_book(address owner) public view returns(uint){
11		return owned_book[owner];
12	}
13}
```

##### 删除

mapping(address => uint256) public balance;

### 7. 其他语法

#### 构造函数

有两个原因：

1.**访问控制**。例如，我们想要发行自己的代币，并且我想定义只有我才能铸造代币。我们可以通过构造函数在部署时设置——谁部署了合约，谁就是所有者。

2.**确保合约正确的初始化**。因为一旦合约部署上链，所有人即可和合约交互，因此我们需要通过构造函数来保证合约部署后所有需要初始化的变量都已经正确的初始化。

什么是构造函数？



构造函数是在合约部署时自动调用且只被调用一次的函数。

![img](https://storage.googleapis.com/hackquest-gcs-prod-asia-northeast1/courses/bb09d46b-60c1-48a0-bad3-a450701e13d7/4af6e987-956d-4c1d-80c7-e05fc52a1484/41d440f6-71ba-4128-8f2b-18451df3c7a5/89f8a928-0474-4cad-857b-48818838d102.webp?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=hackquest-server-prod%40artela-hackquest.iam.gserviceaccount.com%2F20250210%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20250210T090234Z&X-Goog-Expires=3600&X-Goog-SignedHeaders=host&X-Goog-Signature=3352c6385fe0c6a1eff37fb946ea3c37e8182ac0b2115ebfe5b1fe33e453f9bf4ca6f28e664b91fe0d960e6a657ed92351db0e4f70730375accf26b055289c7029c29885ad79b281fb0968d887a976505306347442f62c91b2b48a8be0926551deda42d78225c8cfe27f5a60b6f94404e8cc4d9d9ec29445ab5e69521c2d4380a39dcc00df0adda565938fa2e9b44b3ccf9de140bb8952d812d04ef6bdc22f9394cdf569780efcbbe6d09320344346f8ebe1a93e80c3f33714d1505fb0113038fb663dbf7797c30c1bb68130eff01dd24ec02e0b13ff113df73ba2742db074a7f0060b04bbaad066322bc83c6c11c39ec6ef448ca1bc42188fe080232e7ad12a)

如果你没有定义构造函数，那么在部署合约时，Solidity 将创建一个不执行任何操作的空构造函数。

```solidity
contract A {
5    uint public a;
6		//构造函数，初始化变量a
7    constructor(uint a_) {
8        a = a_;
9    }
10}
```

#### require 断言

require 语句的第一个参数是一个布尔表达式，如果为 *true*，则继续执行程序。如果为 *false*，则会中止执行，并将第二个参数作为错误消息发送到调用者

```solidity
require(recipient != address(0), "Recipient address cannot be zero");
```

#### msg.sender

可以获取本次调用的调用者地址。

address owner = msg.sender;

```solidity
contract VendingMachine {
4    address public owner = address(0x123);
5
6    function buy(uint amount) public {
7				//我们将在下一课中解释msg.sender
8        require(msg.sender == owner, "Not authorized.");
9        // 执行购买操作。
10    }
11}
```

#### msg.value

*msg.value* 用于获取当前函数调用时传递给合约的以太币（ Ether ）数量。它表示当前函数调用中附带的以太币金额，通过读取 *msg.value* 的值，合约可以确定用户向其发送的以太币数量，进而执行相应的逻辑。

msg.value 的单位是？

*msg.value* 的单位是 Wei，是以太坊最小的货币单位。1 Eth = 10^18 Wei。



### 8.  数据存储和处理

到目前为止，我们学了四种值类型变量：*int*、*uint*、*bool*、*address*。

和唯一引用类型变量：mapping



```solidity
1uint a = 10;
2int aa = -3;
3bool b = true;
4address c = address(0x234);
5
6mapping(int => mapping(int => address)) map;
```

#### 存储数据位置

每种引用类型都有一个数据位置，指明变量值应该存储在哪里。Solidity 提供3种类型的数据位置：**storage**、**memory** 和 **calldata**。

##### storage 

所有的状态变量都在 storage 中

位置用于存储合约的状态变量。存储在此位置的数据被持久化存储在以太坊区块链上，因此消耗的gas更大。

![img](https://storage.googleapis.com/hackquest-gcs-prod-asia-northeast1/courses/6aac016b-de54-4180-b779-8186bed222e1/bf54dd72-46b5-4d2a-b986-dcdc43736a1e/aab59473-2f99-419f-9288-efafd6c392e3/e906be7c-d27a-4321-ae5c-bba0f32cc755.webp?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=hackquest-server-prod%40artela-hackquest.iam.gserviceaccount.com%2F20250210%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20250210T091352Z&X-Goog-Expires=3600&X-Goog-SignedHeaders=host&X-Goog-Signature=aadc902c44dc98cb205fcda0b7f4c05735492a4303be0daeb91d91bd84501830d10f02e963443d60146427e6bebc7a6ffdce2e5e9e88e358a203c205c96010a4cbf489e7ae2ee6cfe37c86cefdb4fed4420d05462680c572e97732089c2eee358963797a532163f8802036a171d139f8549cc5f02155f21b0c3e8f08473a47471ee90ff519fb7b11328f344396f0e5ac0b40990fe70981db1e1fea055cdd0ed36f258f6c2d67f4b6c865c28d2e597c95e8097019c832d813de63f52882a33e1b8482bef88565b89953f5d7dbc1f8f6a41edb6f7e86a073257daf3cbc3235a7ce0b02e43813932018bfba81521220bcb08915d727b300cefe1b0fb8d7129bbcf7)

何时使用 storage ？

任何想要**永久存储**在以太坊区块链上的内容都应该存储在 storage 中。

```solidity
1contract MyContract {
2    //在函数外定义的状态变量默认存储在storage中
3	  mapping (int => bool) b; 
4}
```



address storage userAddress;

##### memory 

memory 在 Solidity 中表示一个临时数据存储区域。与 storage 不同，存储在 memory 中的数据在函数调用结束时会被清空，不具有持久性。

与 storage 相比，memory 在 **gas** 成本方面更小，在 memory 中读写数据会划算很多。

```
string memory tempString ="Hello, Solidity";
```



### 9. String字符串

**连接操作**

```
string a = "Hello";
string b = "world";
string memory result = string.concat(a, b);
```

**长度**

```
//值为 hello 的字符串变量
string hi = "hello";
//我们将字符串转换为 bytes，然后调用 length 函数获取长度
uint256 len = bytes(hi).length;
```

### 10. Struct

结构体属性的定义与状态变量的定义相同，只是没有作用域这个概念

```
contract Example {
  //这里我们定义了一个名为Student结构体，其有name，studentId，grade三个属性
  struct Student {
    string name;
    uint256 studentId;
    uint256 grade;
  }
}
```

**初始化**

```
contract Example {
  struct Student {
    string name;
    uint256 studentId;
    uint256 grade;
  }
  //我们在这个函数中初始化了一个Alice学生示例，并将其作为函数的返回值返回
  function testDefinition() public pure returns(Student memory) {
    Student memory student = Student("Alice", 1, 3);
    return student;
  }
}
```

student.name; 访问结构体属性

```solidity
student.name = "Thomas";
```

### 11. 数组

静态数组需要在声明时确定的固定大小，而动态数组的大小可以在运行时进行调整

动态数组有什么优点？

有点像**栈结构**

1.可以在运行时根据需要调整大小。

2.只占用实际元素所需内存空间，节省内存。

3.可以使用多种函数和操作进行元素操作，更加灵活易用。

```
contract Example {
  //这里我们定义了一个名为nums的uint256类型的动态数组
  uint256[] nums;
}
```

**push()**

```
 uint256[] public nums;
  //这里我们像nums数组的末尾依次push了元素1，2，3
  //执行完后该数组的结构应该为[1,2,3]
  function testPush() public {
    nums.push(1);
    nums.push(2);
    nums.push(3);
  }
```

**pop()**

```solidity
  function testPush() public {
8    nums.push(1);
9    nums.push(2);
10    nums.push(3);
11    //执行到这里该数组的结构应该为[1,2,3]
12    //将数组最后一个元素删除
13    nums.pop();
14    //此时数组的结构应该为[1,2]
15  }
```

**length**

names.length;

##### din定长数组

**为什么要使用定长数组？它有哪些优势？**

1.确定长度：长数组的固定长度使得编译器能够在编译时进行更多的优化。

2.更高的效率：定长数组的存储方式是在插槽中连续存储，这使得对数组的访问速度更快，因为可以通过偏移量直接访问元素，而无需进行额外的计算（例如动态数组中的哈希）。

![img](https://storage.googleapis.com/hackquest-gcs-prod-asia-northeast1/courses/6aac016b-de54-4180-b779-8186bed222e1/717da6a3-37bb-4565-8061-5956d6c2c070/035c5305-9bf6-4b67-b565-e20640c08150/878ba028-6dfd-4951-83a0-193c4e0dd35d.webp?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=hackquest-server-prod%40artela-hackquest.iam.gserviceaccount.com%2F20250210%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20250210T093820Z&X-Goog-Expires=3600&X-Goog-SignedHeaders=host&X-Goog-Signature=319767d3ccdc8509b1ff8215b6689097093b6fe27d263d80b32bfabc0f3c9af80b707daedcb04aaf38d87e81fbb97e43b0bcfeabc9210ebf5f3f9757e60dcd24996bef17a10cd8c2874e1d778135e47f2c8fb8b4211be8ab04cc7d863237ee58c2710d8bac39b27d2bd73a90d30bc957f64159df0fba1d41003c65a9c7e523f4b497e550f1a540b32fd8cfffd7746ecc0d30ba46eb3d2356946ec43ebc7f5512eea86316a45e8a69276542f187a6424afc9ea73cf6a2c07b8839a0cbd4e30c026e3f110ee94c70b7eb9b8ad508cc2b9d70ee29730036c557240fbcd701f1ffd1a4c36672a65b5f1690a8143bd12be0e973d90bad30a49f650b60f4b8ab4e1886)

3.节省存储空间：由于定长数组的长度是确定的，存储每个元素所需的空间也是已知的。这使得在存储定长数组时更加高效，因为不需要为存储数组长度而额外分配空间。

4.避免越界错误：定长数组在编译时会检查数组的访问是否越界，并在必要时引发错误。这可以提供更好的安全性，避免在运行时出现数组越界的问题。

定长数组没有 pop()，push() 等语法，只能一次性赋值（见 documentation ）

### 12. 程序流控制

##### if

if (a > 20) { }

##### while

```solidity
while (i < 10) {
3  i++;
4  // 每次迭代执行的代码
5}
```

##### do-while

##### for

```solidity
for (uint i = 0; i < 10; i++) {
2  // 每次迭代执行的代码
3}
```

##### continue

##### break

### 13. 常量

#### Constant

constant 申明的变量不会被写入合约的 *storage* 中，而是直接在编译时被硬编码到字节码中。

这样做的好处是，由于这些常量的值是在字节码中的，所以我们不需要读取存储空间来获取值，从而节省了 *gas* 消耗。



是一种用于定义常量的关键字。常量是在程序执行期间不会发生变化的值。它们在声明后被固定，并且无法在运行时被修改。

```solidity
//将1赋值给了常量NUM。
2uint256 constant NUM = 1;
```

#### immutable 

```
//在这里定义了一个 immutable 的变量 num
uint256 immutable num;

//为了给 immutable 变量赋值，你需要在声明时或者在构造函数中进行初始化。\
//一旦赋值后，它的值就无法更改。
constructor(uint256 _num) {
  num = _num;
}
```

**为什么使用 Immutable ？**

其相较于 *constant* 可以在部署时再为变量赋值，而不是在写合约时，这使得 *immutable* 更加灵活。

immutable 变量在部署时将其硬编码到合约字节码中。这使得访问 immutable 变量的成本较低，因为它们在部署后不需要从 *storage* 中读取。

💡和 constant 一样，immutable 只能用于状态变量的定义。这是因为 immutable修饰的变量也会硬编码到合约的字节码中。

💡你只可以在构造函数中对 immutable 的变量赋值



### 14. 以太坊转账

####  payable 关键字

在函数名和函数参数后，使用 payable 关键字可以使该函数成为一个可支付函数。

```solidity
1//定义了一个可支付函数receivePayment()。
2function receivePayment() payable public { }
```

**什么函数可以使用 payable ？**

只有 public 和 external 的函数支持 *payable* 修饰。因为如果函数在合约外部不可见的话，用户就无法调用函数，也就自然无法给支付以太给函数。



#### 附加ETH

如何附加 ETH ？

调用一个函数并附加 ETH，在调用函数时使用{value: 发送的以太币数量}的语法，并确保函数具有 *payable* 修饰符。

例如，在一个智能合约中有一个接收以太币的存款函数 deposit， 若要调用这个合约的 deposit 函数，并向其发送5个单位的以太币，可以通过以下语法实现：

```solidity
1deposit{value: 5}();
```

![img](https://storage.googleapis.com/hackquest-gcs-prod-asia-northeast1/courses/bfa91fca-b6cf-44a4-8b04-139eccaa6bd8/92c9b418-1ba4-40da-b9f0-05c37366b7ea/9f882a1d-5968-4126-99a7-9246d5f00e27/55f645b4-8b55-4294-b820-486b32cdc215.webp?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=hackquest-server-prod%40artela-hackquest.iam.gserviceaccount.com%2F20250210%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20250210T100040Z&X-Goog-Expires=3600&X-Goog-SignedHeaders=host&X-Goog-Signature=6f5e5574cd7481afad48976dd7da31bc1b22a99f0eaadb172ddb0bdbbf8074c1370d8956db080affe864e51eaa72d08ab7d1904ef297b884e4ac4d43bead0df8324ec7fc22199e63f1e3654bd8d1306565ec529709d31e55797399838989448d5fbac66b0940333b7e86b4961f6cac012eaab1d74a9240d859d73d92d033457f0f898e856ef4bf1a123cf619e4a6b1ddc39d85e603264551d4054087888a8b060e9380fd36a1a4bba393262f10917d3b0779d9edd099a5cb4134e65490e0713d42ecee1d526e379036852789b129e86cc8b2543020f9d8e532a7c03bd9afde61ae0da274da5980f3c5f5eb7da448742d6a9d2da90de57e99923e6cec99a60ffb)

调用成功的前提是:在调用该函数时，合约 B 中有大于5 wei 的余额。

```
pragma solidity ^0.8.0;

// 定义 Bank 合约
contract Bank {
  mapping(address => uint256) public balances;

  // 定义带有 payable 修饰符的 deposit 函数，以便接收以太币
  function deposit() public payable {
    balances[msg.sender] += msg.value;
  }
}

// 定义用于与 Bank 合约进行交互的 User 合约
contract User {
  Bank public bank;

  // 构造函数，用于设置 Bank 合约地址
  constructor(address _bankAddress) {
    bank = Bank(_bankAddress);
  }

  // 调用 Bank 合约的 deposit 函数并发送以太币
  function depositToBank() public payable {
    // 调用deposit函数并传入ETH
    // 调用成功的前提是:在调用该函数时，该合约里有大于5wei的余额。
    bank.deposit{value: 5}();
  }
}
```

#### block.number全局变量

指当前的区块高度，也就是当前区块在整个区块链中的位置。每个新的区块都会递增这个值，所以它可以用来确定某个区块在区块链中的相对位置。

*block.number* 类似于产品的序列号，产品序列号用于唯一标识产品在生产中的顺序编号。每当一个新的区块被添加到区块链上时，它会被分配一个唯一的区块号（又称区块高度，每一个新产生的区块的区块号是递增的），就像产品在生产过程中被分配一个唯一的序列号。

```
//通过block.number返回当前区块的高度，并赋值给了变量blockNumber。
uint256 blockNumber = block.number;
```

#### block.timestamp全局变量

 它是指当前区块的时间戳,当前区块生成时距离1970年1月1日的秒数

```
//通过 block.timestamp 返回当前区块的时间戳，并赋值给了变量 blockTimestamp。
uint256 blockTimestamp = block.timestamp;
```

### *15. 事件*

在 solidity 中我们使用event关键字来声明一个事件，其后是事件名，随后用括号把参数括起来。

```solidity
1//在这里我们定义了一个名为EventName的事件，其有parameter1和parameter2两个参数。
2event EventName(
3  uint256 parameter1,
4  uint256 parameter2
5);
```



什么时候需要使用事件？

假设你是一个电商平台的管理员，你有一个智能合约来处理用户下单的过程。当有人下单时，你需要通知所有相关方，例如买家、卖家和物流公司。

如何使用事件？

1.定义一个名为 **Order** 的事件，里面包括下单者的地址，下单的物品，下单的数量。

```solidity
1event Order(address sender, string goods, uint count);
```

2.在有人下单的时候广播 **Order** 事件，这样所有人都可以收到下单者的地址，下单的物品，下单的数量这三个信息。

#### emit关键字

事件本身只是一个定义或声明，它规定了哪些信息可以被记录或广播。但仅仅定义事件并不足以让其他人或系统知道某件事已经发生了。

在 Solidity 中，要广播一个事件，你需要使用 emit 关键字。emit 用于初始化事件，并根据事件的定义设置所有需要的信息，然后广播这个事件。这样，所有订阅了该事件的人或系统就会收到通知。

```
//在这里我们提交了一个名为MessageSent的事件，参数分别为msg.sender和message。
emit MessageSent(msg.sender, message);
```

#### indexed关键字-高效事件参数索引

`indexed`修饰符的作用是为事件参数创建一个可搜索的索引，以便更高效地过滤和检索事件。

在 Solidity 中，事件的参数默认是*不可搜索*的，也就是说，你不能直接根据事件参数的值来过滤和搜索事件。然而，当你将某个参数标记为 *indexed* 时，Solidity 会为该参数创建一个额外的索引，使得你可以根据该参数的值进行过滤和搜索。

```
contract EventExample {
  // 定义事件，其中sender可被搜索
  event MessageSent(address indexed sender, string message);

  // 发送消息函数
  function sendMessage(string memory message) public {
    // 触发事件
    emit MessageSent(msg.sender, message);
  }
}
```

开发DApp、进行日志分析和数据查询时非常有用。

### 16. 合约类型

*合约类型*是 Solidity 中的一种变量类型，用于存储对其他合约的引用。

合约类型的变量就是一个合约的实例。这个实例可以访问合约的所有公共函数和变量

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 合约A
contract ContractA {
    uint256 public data;
}

// 合约B
contract ContractB {
    //定义了一个ContractA的合约类型变量
    ContractA public contractA;
    ContractA public contractAA;

    constructor(address _contractA) {
        //将传入的合约地址实例化为ContractA合约，并将其赋值给contractA变量
        contractA = ContractA(_contractA);
        contractAA = new ContractA();
    }
}
```

#### 调用

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 合约B
contract B {
  uint public result;

  function foo(uint _input) public {
    result = _input * 2;
  }
}

// 合约A
contract A {
  B public b;

  constructor(address _bAddress) {
    b = B(_bAddress);
  }
  //调用B合约的foo函数
  function callBFunction(uint _input) public {
    b.foo(_input);
  }
}
```

#### 获取其他合约变量

```
contract NFTContract {
  uint public totalSupply;
}

contract MarketplaceContract {
  NFTContract public nft;

  function getTotalSupply() public view returns (uint) {
    return nft.totalSupply();
  }
}
```

### 17.  Enum

```
enum City {
  BeiJing,
  HangZhou,
  ChengDu
}
```

一个枚举类型最多有多少个值？

256个。因为枚举类型是以uint8存储的，而uint8的最大值为2的8次方就是0-255。所以一个枚举类型最多可以定义256个值，分别对应到uint8 的 0到255 。

```
City favoriteCity = City.Tokyo;
```

最大值

```
//我们使用type(枚举名).max的语法获取到了Color这个枚举的最大值。
Color a = type(Color).max;
Color b = type(Color).min;
```

### 18. 函数修饰符

#### modifier 

函数修饰符（ modifier ）。

*函数修饰符*允许开发人员在函数执行前后或期间插入代码，以便修改函数的行为或确保特定的条件得到满足，函数修饰符内的代码的不能被独立执行。

```
pragma solidity ^0.8.0;

contract Example {
  address public owner;
  uint public value;

  // 定义了一个名为onlyOwner的函数修饰符（如果没有参数，可以省略()
  modifier onlyOwner {
    require(msg.sender == owner, "Only the contract owner can call this function.");
    _; // 继续执行被修饰的函数（在下一节中会讲）
  }

  constructor() {
    owner = msg.sender;
  }
  // 被onlyOwner修饰的函数（后面会讲）
  function setValue(uint _newValue) public onlyOwner {
    value = _newValue;
  }
}
```

_; 的作用是告诉编译器要在什么时候执行被修饰函数的代码。

```
modifier demo() {
  ...  // 函数执行前执行的代码
  _;   // 执行被修饰的函数
  ...  // 函数执行结束后执行的代码
}
```

**多个修饰符**

```
pragma solidity ^0.8.0;

contract MyContract {
  address public owner;

  constructor() {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "Only owner can call this function.");
    _;
  }

  modifier notNull(address newOwner) {
    require(newOwner != address(0), "New owner's address must not be zero.");
    _;
  }

  function changeOwner(address newOwner) public onlyOwner notNull(newOwner) {
    owner = newOwner;
  }
}
```

## 二、语法进阶

### 2. 错误处理机制

#### 2.1 revert

revert()函数在没有任何参数的情况下使用，用于终止函数的执行并回滚所有状态变化。它会自动返回一个默认的错误消息，指示函数执行失败。

也可以在 revert 关键字后附带一个字符串参数，以提供自定义的错误消息。这样可以在函数终止时提供更具体和详细的错误信息，方便开发者和用户理解发生的错误。

```solidity
1revert();
2revert("Custom error message");
```



revert和require有何异同？

从底层的角度来看，两种方法是相同的。两者都会抛出一个异常。例如，下面revert语句和require语句是等价的。

在 gas 消耗方面，两者一样都会将剩余的 gas 费返还给调用者。

```solidity
1if (num == 1) { 
2		revert(‘Something bad happened’);
3}
4
5require(num == 1, ‘Something bad happened’);
```

#### 2.2 error

**自定义**的错误类型：错误(error)，用于表示合约执行过程中的异常情况。它可以让开发者定义特定的错误状态，以便在合约的执行过程中进行特定的异常处理

```
//使用error关键字定义了一个名为MyCustomError的自定义错误类型
//并指定错误消息类型为string 和 uint。
error MyCustomError(string message, uint number);

function process(uint256 value) public pure {

		//检查value是否超过了100。如果超过了限制，我们使用revert语句抛出自定义错误
		//并传递错误消息"Value exceeds limit" 和value。
		if (value >100) revert MyCustomError("Value exceeds limit",value);

}
```

#### 2.3 assert

```
//确认a 和 b在任何情况下都相等
assert(a == b);
```

#### 2.4 try catch

```
try recipient.send(amount) {
    // 正常执行的处理逻辑
} catch Error(string memory err) {
    // 捕获特定错误类型为Error的处理逻辑
    // 可以根据错误信息err进行相应的处理
} catch (bytes memory) {
    // 捕获其他错误类型的处理逻辑
    // 处理除了已声明的特定类型之外的所有错误
}
```

### 3.  library

```
pragma solidity ^0.8.0;

//定义MathLibrary 库
library MathLibrary {
		//库中可以定义函数
    function square(uint256 x) external pure returns (uint256) {
        return x * x;
    }
}
```

library 在使用上有什么限制

Solidity 对库的使用有一定的限制。以下是 Solidity 库的主要特征。

1.库不能定义状态变量；

2.库不能发送接收以太币；

3.库不可以被销毁，因为它是无状态的。

4.库不能继承和被继承；



#### 3.1 调用

```
library MathLibrary {
    function square(uint256 x) external pure returns (uint256) {
        return x * x;
    }
}

contract ExampleContract {
    function calculateSquare(uint256 y) external pure returns (uint256) {
        // 调用库合约的函数
        uint256 result = MathLibrary.square(y);
        return result;
    }
}
```

#### 3.2 将库中函数附加到某个类型

使用using...for...语句可以将库中的函数附加到某个类型中。

```
//将 MathLibrary 库附加到 uint256 类型上
//这样所有的 uint256 类型的变量都可以直接使用 MathLibrary 库中的函数
using MathLibrary for uint256;
```



#### 3.3 import

```solidity
// 导入其他合约
import "./OtherContract.sol";

contract ExampleContract {
    // 使用导入的合约
    OtherContract public otherContract;
```

### 4. 继承

#### 4.1 is

继承可以理解为一种家族关系，就像父母将自己的特征传给孩子一样，一个合约（父合约）可以将自己的属性和函数传递给另一个合约（子合约）。继承的合约可以访问所有非 private 的成员。

```
contract ChildContract is ParentContract { }
```

#### 4.2 构造函数继承

```
//这里我们继承了ERC20并在构造函数中对ERC20中的构造函数进行了初始化。
constructor(string name, string symbol) ERC20(name, symbol) { }
```

```
pragma solidity ^0.8.0;

// 合约B
contract B {
    uint public bValue;

    constructor(uint _value) {
        bValue = _value;
    }
}

// 合约A 继承合约B
contract A is B {
    uint public aValue;
		// _valueA用于初始化aValue，
		// _valueB用于调用合约B的构造函数初始化bValue 继承的合约参数类型不用写
    constructor(uint _valueA, uint _valueB) B(_valueB) {
        aValue = _valueA;
    }
}
```

#### 4.3 覆盖函数override

函数覆盖是指在子合约中**重新实现**从父合约继承的函数。这意味着子合约可以在自己的代码中提供新的函数实现，以**替换**父合约中原有的函数实现。

覆盖函数必须使用与被覆盖函数**相同**的函数名称、参数列表和返回类型，否则该合约会编译失败。

```

//这里定义了一个foo函数,并使用override关键字覆盖了父合约中的foo函数。
function foo() public override {
    
}
```

#### 4.4 virtual

可以使用virtual关键字来标记函数为可重写的，然后在子合约中使用override关键字对其进行*覆盖*。

**什么样的函数需要使用 virtual 关键字？**

需要注意的是，并非所有函数都需要使用virtual关键字。只有那些有可能需要在子合约中进行修改或定制的函数才需要被其标记。

对于那些需要保持一致性的函数，可以不使用virtual关键字，从而确保其在继承的合约中的实现保持一致。

因为他们不可以被重写，因此父合约所写的函数将原封不动的存在于子合约中。

#### 4.5 super

在子合约中用于调用父合约的函数和变量

```
//这里我们调用了父合约中的init函数。
super.init();
```

#### 4.6 多重继承

```
//值得一提的是在多重继承时，super究竟指向哪一个父合约呢？
//事实是写在最后面的合约会被super调用。
contract Child is Parent1, Parent2 { 

		function foo() public {
				super.foo(); // 这会调用Paren2的foo函数
		}	
}

```

### 5. 接口

接口有哪些特性？

●接口不能实现任何函数；

●接口无法*继承*其它合约，但可以*继承*其它接口；

●接口中的所有函数声明必须是external的；

●接口不能定义*构造函数*；

●接口不能定义*状态变量*；

```
interface MyInterface {
    function myFunction(uint256 x) external returns (uint256);
}
定义了一个名为 MyInterface 的接口，其中有一个接口函数 myFunction 。
```



#### 5.1 交互

```
//先定义一个接口变量otherContract
OtherContractInterface  otherContract = OtherContractInterface(otherContractAddress);
//随后使用interface.getValue()调用otherContract的getValue函数
otherContract.getValue();
```



```
pragma solidity ^0.8.0;

// 定义接口
interface OtherContractInterface {
    function getValue() external view returns (uint256);
    function setValue(uint256 newValue) external;
}

// 合约A
contract ContractA {
    uint256 public value;

    function setValue(uint256 newValue) public {
        value = newValue;
    }
		//参数为B合约地址,随后使用接口调用B合约
    function callGetValue(address contractAAddress) public view returns (uint256) {
        ContractB contractB = ContractB(contractAAddress);
        return contractB.getOtherContractValue();
    }
}

// 合约B
contract ContractB {
		//接口类型的变量，类似与合约变量
    OtherContractInterface public otherContract;
		
		//在构造函数中为其赋值
    constructor(address otherContractAddress) {
        otherContract = OtherContractInterface(otherContractAddress);
    }
		//使用接口调用setValue函数
    function callSetValue(uint256 newValue) public {
        otherContract.setValue(newValue);
    }

    function getOtherContractValue() public view returns (uint256) {
        return 5;
    }
}
```

#### 5.2 继承 

```
//在这里我们定义了一个合约ContractA并继承了InterfaceA接口，
//这意味着我们必须实现InterfaceA中规定的所有函数。
contract ContractA is InterfaceA { }
```

### 6. abstract

**抽象合约和普通合约的区别？**

抽象合约和普通合约的唯一区别在于能否被*部署*。

```solidity
1abstractContract = MyAbstractContract(abstractAddress);  // error，抽象合约不能被部署
2regularContract = MyRegularContract(regularAddress);     // success
```

**抽象合约和接口的区别？**

抽象合约和接口的最大区别在于，抽象合约可以包含*变量*和实现，而接口只包含没有实现的*函数*。

```
//这里我们定义了一个抽象合约ContractA
abstract contract ContractA { }
```



### 7. hash哈希计算

哈希计算是一种将任意长度的数据转换为固定长度哈希值的过程

**有哪些哈希算法？**

Keccak256 和 SHA3 是用于哈希计算的两个算法。

然而由于在以太坊的开发过程中，SHA3 还处于标准化阶段，以太坊开发团队选择了使用 Keccak256 来代替它。所以 EVM 和 solidity 中的 Keccak256 和 SHA3 都是使用 Keccak256 算法计算的哈希。为了避免概念混淆，在合约代码中直接使用 Keccak256 是最清晰和推荐的做法



**keccak256** 是一个全局函数，可以在函数中直接使用该函数进行哈希计算。

●输入：只接受bytes类型的输入。

●输出：bytes32长度的字节。

```solidity
1//这里我们将字符串”HackQuest"转换成字节数组后，进行哈希的结果赋值给了res变量。
2bytes32 res = keccak256(bytes("HackQuest"));
```

### 8. 特殊函数

#### 8.1  receive

receive 函数只用于处理接收 ETH，一个合约最多只有一个，而且不能有任何的参数，不能返回任何值，必须包含 [external ](https://www.hackquest.io/458b9ca2618a45628ca8d3a5b2a504a5)和 payable 

***receive* 函数是必须的吗**

不是的，你可以选择定义 *receive* 也可以不定义，但是如果不定义，在合约收到转账时可能会报错。

***receive* 除了不能有参数和返回值之外和其他的函数还有什么区别？**

receive 限制只能消耗2300 gas，这个数量的 gas 基本就只能收个 Ether

```
//这里我们定义一个空的receive函数。 必须包含external和payable。
receive() external payable { ... }
```

#### 8.2 fallback

fallback 函数充当了合约的默认处理函数，用于处理没有明确定义处理方式的消息。

*fallback* 函数会在三种情况下被调用

1.调用者尝试调用一个合约中不存在的函数时

2.用户给合约发 Ether 但是 *receive* 函数不存在

3.用户发 Ether，*receive* 存在，但是同时用户还发了别的数据（ [msg.data](http://msg.data/) 不为空）

**比喻**

假设合约就像是一个快递员，当快递员收到一个包裹时，如果地址清晰，就按地址送达。如果地址不清晰，就执行默认操作，例如将包裹送回快递站。

在这个比喻中，*fallback 函数*就类似于快递员的默认操作。当你在合约中调用一个未定义的函数或者向合约发送以太币但合约中没有 *receice* 函数时，Solidity 会调用 *fallback* 函数作为默认处理方式。

**每个合约都必须写 fallback 吗？**

并不是每个合约都必须编写 fallback 函数。*fallback* 和 *receive* 一样都不是必须的。

**fallback 和 receive 的区别？**

二者都是处理 solidity 中默认逻辑的函数。fallback 可以不用被 payable 修饰，而 receive 必须被 payable 修饰。当 fallback 被定义为 payable 时，也可以充当 receive 的作用来接收 ETH 。

receive 像一个专门接收现金的收银员。当客户只是想付现金，而不需要任何其他服务时，他们就会去找这个收银员。

receive 不会默认存在在合约中。

**什么时候触发 fallback 函数 | receive 函数?**

```
pragma solidity >=0.6.0;
contract MixedExample {
    event Received(address sender, uint amount);
    event FallbackCalled(address sender, uint amount);
    // 当纯以太币转账时触发
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
    // 当调用不存在的函数或附加了数据时触发
    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.value);
    }
}
```



简单来说，合约接收 ETH 时，msg.data 为空且存在receive() 时，会触发 receive()；*msg.data* 不为空或不存在 receive() 时，会触发 fallback() ，此时 fallback() 必须为 payable 。

需要注意的是，如果合约中既没有 **receive** 函数，也没有 **payable** 修饰的 **fallback** 函数，那么直接向合约发送以太币的操作将会失败，合约会拒绝接收以太币。但是，你仍然可以通过调用带有 **payable** 修饰的其他函数来向合约发送以太币。

```
//这里我们定义了一个空的fallback函数。
fallback() external { }
fallback() external payable {...}
```

### 9. 内置函数

#### 9.1 selfdestruct-不使用

有安全隐患

```
//我们调用selfdestruct函数，指定将合约中剩余的ETH发送给targetAddress地址。
selfdestruct(targetAddress);
```

#### 9.2 时间单位day

```
uint256 minute = 1 minutes;
uint256 minute = minutes; // 错误用法
uint256 hour= 1 hours;
uint256 day= 1 days;
uint256 week= 1 weeks;
```

### 10. ABI

#### 10.1 abi.encode

全局函数 abi.encode，它用于对给定的参数进行 **ABI** 编码，返回一个*字节**数组*。

ABI (Application Binary Interface，应用二进制接口)是与以太坊智能合约交互的标准。在 **EVM** 处理数据时，所有的数据根据 **ABI** 标准进行编码。

**比喻**

就像人们在交流时需要共同的语言和规则一样，智能合约与外部世界进行交互时也需要一种共同的语言和规则。**ABI** 提供了这种共同的语言和规则，使得智能合约的函数调用和数据交换能够被正确编码和解码。

区块链外部-> ABI -> 智能合约  反过来也是

**为什么要使用 abi.encode ？**

abi.encode 是 Solidity 提供的一个非常有用的工具，用于将多个参数或变量编码为一个连续的字节数组，这在与智能合约交互时尤为重要。以下是使用abi.encode 的几个主要原因：

1.**标准化编码**：当与智能合约交互时，需要确保数据以特定的格式进行编码和解码。abi.encode 确保了数据按照 **Ethereum** 的 **ABI** 规范进行编码，从而确保数据的正确性和一致性。

2.**提高代码可读性**：直接使用 abi.encode 可以使代码更加简洁和可读，因为开发者不需要手动进行复杂的编码操作。

3.**安全性**：手动编码数据可能会导致错误，而 abi.encode 提供了一种安全、一致的方法来编码数据，从而减少了出错的可能性。

4.**灵活性**：abi.encode 可以用于编码各种不同的数据类型，包括结构体、数组和基本数据类型，这为开发者提供了很大的灵活性。

5.**与其他函数和库的兼容性**：许多 Ethereum 的函数和库都期望数据以特定的 ABI 格式进行编码。使用 abi.encode 可以确保与这些函数和库的兼容性。

abi.encode 是一个强大的工具，它简化了与智能合约交互的过程，确保了数据的正确性和一致性。



可以直接在函数中调用abi.encode()函数对数据进行编码。

```solidity
1bytes memory encodedData = abi.encode(param1, param2);
```

●**param1** 和 **param2**：这是要编码的参数。根据参数的类型，它们将被编码为**字节数组**。

●**encodedData**：这是一个 *bytes* 类型的变量，用于存储通过 abi.encode(param1, param2) 对参数进行编码后的数据。编码后的数据将按照参数的类型和顺序进行紧凑的编码，形成一个动态*字节数组*。

#### 10.2 abi.decode

**什么时候需要使用 abi.decode？**

当我们与智能合约交互或在合约之间传递数据时，为了确保数据的完整性和一致性，我们经常使用 abi.encode 对数据进行编码。编码后的数据是一个*字节数组*，它代表了原始数据的 **ABI** 编码形式。

*abi.decode* 的使用场景主要包括：

1.**数据验证**：当我们从外部源（如其他合约或外部调用）接收到编码的数据并需要验证其内容时，我们会使用 abi.decode。

2.**事件****日志解析**：当我们从智能合约的事件日志中获取编码的数据并希望解析它以获取具体的参数值时。

3.**跨合约调用**：当一个合约向另一个合约发送编码的数据，并且接收方合约需要解码这些数据以进行进一步的处理。

4.**存储和恢复**：当我们在合约的存储中保存编码的数据并在以后需要恢复原始数据时。

当我们面对已经被 abi.encode 编码的数据并需要访问其原始形式时，我们就会使用 abi.decode。





使用 abi.decode() 函数可以对编码后的数据进行解码。第一个参数是编码数据的*字节数组*，第二个参数是解码后的数据类型。

```solidity
address decodedAddress = abi.decode(encodedData, (address));

//多个参数
(uint256 decodedUint, address decodedAddress, string memory decodedString) = abi.decode(encodedData, (uint256, address, string));
```

#### 10.3 abi.encodePacked

这是一个与 abi.encode 类似但有所不同的全局函数。它也用于将参数编码为符合 **ABI** 标准的*字节数组*，但不会为每个参数添加其类型的长度信息，也不会在参数之间添加分隔符，结果是一个紧密打包的字节数组。

**和 abi.encode 有什么区别？**

主要区别在于数据的压缩。

●abi.encodePacked 将参数紧密打包，就像将物品紧密地放在一起，没有任何额外的填充物或间隔。这种打包方式可以节省空间，但在解包时需要小心处理，因为物品之间没有明确的分隔符。

●相比之下，abi.encode 使用标准的分隔符和填充物进行组织。就像将物品放入不同的袋子，并每个袋子都有标签和规范，以确保物品的结构和类型完整性。尽管可能需要更多的空间，但在解包时更容易处理和识别每个物品。

![img](https://storage.googleapis.com/hackquest-gcs-prod-asia-northeast1/courses/aa0dba1e-2517-472b-991f-bcf64583bb6d/a1f4923f-91de-445f-858d-d766581522b9/7d5c90a2-ee2b-415c-87e6-d781a9c6ca5f/88aa256c-ae38-4229-8b43-85242372906e.webp?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=hackquest-server-prod%40artela-hackquest.iam.gserviceaccount.com%2F20250211%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20250211T080612Z&X-Goog-Expires=3600&X-Goog-SignedHeaders=host&X-Goog-Signature=c1248fa434d4b29e16403c8d1ea5766c35c146991ca35c9bd83a5fe724a5db9ba463e3b50f5df176fb444c9edf0e05ffc11c72b7697a53bf46188c07b9c00ddcab7163cc3b26b495c4e73bb476cc2031f33ad24b63e10a0c7aa31ed8b3105c652ef76944d0f96e3d714ad00a3beb711561e9ec08cf867dd74a1ea793e68c6ef210689692c745d1ed36db10c0a845d0d9e45a45d36db8970e1535e96f22e0af538aa6d128e836dec24e6cf55f43f6db19426c2313a42b18384ed611363d86355f1cbd53c7461094009c2563dd873249e1796c9ee426703d269dac761bd11704ba2e24579f3b13084fe737d9d613ce6a180a592fe6be824fb75fbdd9cc56f38e3f)

💡

由于紧密打包的特点，abi.encodePacked 不能编码结构体和嵌套数组。

**使用场景？**

abi.encodePacked 一般用在 *hash* 上。因为 *abi.encodePacked* 会比 *abi.encode* 编码出来的数据更短，所消耗的 *gas* 成本更低。

如果需要编码的数据中有两个动态数组，abi.encodePacked 可能会将两组数据编码成同一个字符串，这种时候应该使用 *abi.encode* 而不是 *abi.encodePacked*。

```
bytes memory encodedData = abi.encodePacked(param1, param2);
```

#### 10.4 函数签名

函数签名是一个函数的唯一标识符，它由*函数名*和*参数类型*组成

**两个不同的函数的函数签名可能相同吗？**

在同一个合约里不可能，Solidity 不允许同一个合约里面有两个函数有相同的函数签名因为 Solidity 通过函数签名的哈希值前四位定位需要调用的函数，如果函数签名一样，那哈希值前四位也会一样，这样的话没有办法确定到底调用哪个。

在不同的合约里则可能。只要函数名，参数类型和顺序一致就 OK 。





函数签名是*函数名*+*参数字段类型*的字符串。没有空格，不用缩写。

```solidity
1function hello(uint256 a, address b, bool c) {...}
2signature = "hello(uint256,address,bool)"；
```

#### 10.5 函数选择器

函数选择器是*函数签名*的哈希前四个字节，用于在编码后的数据中唯一标识函数。

在 Solidity 中，所有函数调用其实是通过函数选择器作为唯一标识。



函数选择器是函数签名的哈希前4个字节。在这里我们直接取函数签名的前4个字节即可，或者也可以直接使用functionName.selector

```
bytes4 selector = bytes4(keccak256(signature));
bytes4 selector = myFunction.selector;
```

bytes4 selector = bytes4(keccak256("transfer(address,uint256)"));

#### 10.6 数据编码方式

#####  abi.encodeWithSignature 

函数调用可能会失败，但是我们不希望调用失败后交易直接回滚。这时候，我们就需要 abi.encodeWithSignature 去和底层 **EVM** 交互



可以直接在函数中调用abi.encodeWithSignature函数对数据进行编码。需要两种参数

1.*函数签名*

2.函数具体参数

```solidity
1abi.encodeWithSignature("myFunction(uint256,string)", 123, "Hello");
```

在上述代码中，我们使用了 abi.encodeWithSignature 函数来编码*函数签名*和*参数*。



**abi.encodeWithSignature 函数和 abi.encode 函数以及 abi.encodePacked 函数有什么区别？**

●abi.encodeWithSignature 编码函数的签名和参数。类似于在菜谱上写下菜名（函数签名）和制作材料（参数），这样厨师就知道该做哪道菜以及需要哪些材料。

●abi.encode 和 abi.encodePacked 编码函数的参数，但不包括函数的签名。类似于菜谱上写下了制作材料（*参数*），没有写菜名（*函数签名*）。这种情况下，厨师知道需要使用哪些材料，但不知道应该制作哪道菜。

![img](https://storage.googleapis.com/hackquest-gcs-prod-asia-northeast1/courses/aa0dba1e-2517-472b-991f-bcf64583bb6d/96734bf2-e2f9-4300-89a1-2d48a221c7a1/b282cd17-e568-4fc5-8fca-deade18a5e74/02e2ac82-2be4-4df3-82dd-2866b4659ad2.webp?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=hackquest-server-prod%40artela-hackquest.iam.gserviceaccount.com%2F20250211%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20250211T081157Z&X-Goog-Expires=3600&X-Goog-SignedHeaders=host&X-Goog-Signature=6d0cbd3d5c05643b63f680f3ce0726595ddff86eab9bb3f4ebc52dada0e43b74362f8f6bc273511df7ed87be8e6c8e03cc01da99375bb6e50a8a434f46f8aee21cec9adbf85628b0c46b44f971fae7cdec1785666c6b552299741522586acdbca6ff065944f7187761978c3bd9a2dadcf2665402011435a9cf732be5066f1ca09ea276e6c58d629dbaca5ed592feec9c8b910affc46a3e63885b29ac30738ac815d16e8c63df490d69225e059d506d2fb8dbc95ad8995cffa570f762ef2aa54cf476649305ed317cfc15fdeb487565a389fd92640b242d070cf7311e279aacc6038bef43533664be64228570227d75bc7794fc241a31c0a2b5e8adfa11f1b13f)

abi.encode 和 abi.encodePacked 更多的用途是在数据的存储和哈希上，而abi.encodeWithSignature 则是用于低级调用

##### abi.encodeWithSelector

可以直接在函数中调用 abi.encodeWithSelector 函数对数据进行编码。并通过bytes4(keccak256("函数名(参数列表)"))的方式获取函数的选择器。



```solidity
1abi.encodeWithSelector(bytes4(keccak256("myFunction(uint256,string)")),123, "Hello");
2
3//可以通过函数名.selector()的方式获取函数的选择器。
4bytes4 selector = this.myFunction.selector;
5abi.encodeWithSelector(selector, 123, "Hello");
```

#### 10.7 低级调用

低级调用其实是直接和 **EVM**（以太坊虚拟机）交互的一种调用方式，因此它具有更高的灵活性。

##### address.call

低级调用只需要知道要交互的合约地址即可，不需要提供*接口*和*合约变量*。

最基础的*低级调用*通常使用 address.call 函数来实现。

```solidity
1//abiEncodedData为我们上一章中提到的abi.encodeWithSignature
2//和abi.encodeWithSelector的结果
3(bool success, bytes memory data) = address(targetAddress).call{value: amount}(abiEncodedData);
```

在上述语法中：

●**targetAddress**：是目标合约的地址。

●**value**：是可选参数，用于向目标合约发送以太币。

●**abiEncodedData**：是目标合约函数的ABI编码数据（通过 abi.encodeWithSignature 或者 abi.encodeWithSelector 编码）。

```
// 低级的 call 调用 targetAddress 地址的 dosome(uint256 amount) 函数，传参为5。（使用 abi.encodeWithSignature ）
address(targetAddress).call(abi.encodeWithSignature("dosome(uint256)", 5));
```

##### delegatecall 

delegatecall 的语法与 call 语法一致，使用address.delegatecall() 来实现。

```solidity
1(bool success, bytes memory data) = address(targetAddress).delegatecall(abiEncodedData);
```

在上述语法中：

●**targetAddress**：是目标合约的地址。

●**abiEncodedData**：是目标合约函数的 *ABI* 编码数据。



**什么时候需要这么做？**

由于部署的 Solidity 合约不可更改，那我们希望更新函数功能的话怎么办呢？我们先部署一个代理合约 A，在里面 delegatecall 合约 B 的功能。

更新时，只需要更改合约 B 的地址变成合约 C，这样合约 A 就可以使用新版合约 C 的功能

#### 10.8 msg.data全局变量

msg.data 是一个 *bytes* 类型，它包含了函数调用的原始数据。通过使用 *msg.data*，您可以访问传递给函数的原始字节数据，进而进行解析和处理

假设你在一家快餐店点餐，快餐店是智能合约，你是与合约互动的用户。你可能会说：“我要一个巨无霸套餐，加大薯条，可乐换成雪碧。”这句话就类似于 msg.data，它告诉快餐店（智能合约）你要执行的操作，以及相关的参数（巨无霸套餐、加大薯条、可乐换成雪碧）。

```
bytes memory data = msg.data;
```



## 三、代币标准

推荐 https://decert.me/tutorial/solidity/solidity-practice/erc20

### **ECR-20**

代幣標準 ERC-20 是在 2015 年提出，最終於 2017 年與以太坊上正式安裝完成。在去中心化的生態系統中，這種制式的代幣標準被廣泛的使用在多種用途上。由於 ERC-20 本身就是一套規範區塊鏈行為的標準，使得他不但被大多數個人使用者接受，也相當受到一些組織或是機構的歡迎，可以說在ERC-20規範下的以太幣，對於以太坊上的ICO、眾籌、穩定幣建立等活動來說是非常有利的。

**簡單來說，一個代幣如果是基於ERC-20標準，那它最重要的特性就是代幣間的「同質化」，就好比說你手上的10塊錢硬幣，和我錢包內的10塊錢硬幣一樣，兩者價值完全相同，沒有哪一枚硬幣比較特殊的問題。**

一般來說，ERC-20同質化代幣具有兩種特性，分別是可替代性以及可分割性：

- 可替代性：表示每顆加密貨幣就有同等價值、功能相同，不同用戶手中的以太幣並沒有區別，彼此之間可以任意交換使用，可以使用公定的價格進行交易。
- 可分割性：與我們經常使用的法幣不同，法幣購買時的最小單位是1元，加密貨幣雖然使用顆或者枚作為單位，但卻不用以整數進行交易，例如使用以太幣購買NFT時，就能以0.08顆以太幣進行交易，這就是它的可分割性。



### **ERC-721**

不同於前者，ERC-721旨在創造具有不可替代性以及不可分割性的代幣，也就是大家所熟悉的非同質化代幣–NFT (Non-Fungible Token)。

- 不可替代性：每個NFT都具有它的獨特性，獨一無二且無法取代，同樣被儲存在鏈上後，也無法隨便刪除。
- 不可分割性：除非智能合約允許，否則NFT是沒辦法像加密貨幣一樣，被拆成更小的份數進行交易。

那究竟能以ERC-721創造什麼？

其實只要一個物件能具有特殊價值，就適合以這種代幣標準被創造出，比如藝術創作、音樂，或者是目前最常見的個人頭像、PFP，一般來說是沒辦法找到另一個價值完全對等的ERC-721代幣。

NFT也可以看做一個數位創作或資產的所有權，與以往的藝術作品不同，NFT作為獨特的數位代幣，創作者可以透過版費(royalties)的方式，在每一筆交易中持續獲得收入，就算買賣雙方沒有創作者參與也是如此。



### **ERC-1155**

ERC-1155 則是多重代幣標準，全名為 Multi Token Standard。ERC-1155 的用途為再製、包裝或組合一個至多個 Token Type 或 NFT Collection，讓 Token Type 或 NFT Collection 有繼承、多型、封裝等功能。

舉例來說，小明想購買某遊戲的帽子+衣服+褲子+鞋子，以往遊戲只能讓小明一個一個買，一筆交易一筆交易打，有了 ERC-1155 後，遊戲項目方開始可以賣小明一個全身套裝了，四種 NFT 也可以一次性打給小明。

這個協議主要功能是因為區塊鏈容量並非無上限，因此要阻止開發者們無限量開發智能合約，藉由傳統物件導向概念降低智能合約發布數量、提升開發效率。附加效果則是增加使用者體驗，讓使用者擁有套裝、多型態代幣等豐富選擇。



## openzeppelin

```
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    constructor(address initialOwner)
        ERC20("MyToken", "MTK")
        Ownable(initialOwner)
    {
        _mint(msg.sender, 10000 * 10 ** decimals());
    }
}
```

## 交易参数组成

```
const transactionParameters = {
  nonce: '0x00', // ignored by OKX
  gasPrice: '0x09184e72a000', // customizable by user during OKX confirmation.
  gas: '0x2710', // customizable by user during OKX confirmation.
  to: '0x0000000000000000000000000000000000000000', // Required except during contract publications.
  from: okxwallet.selectedAddress, // must match user's active address.
  value: '0x00', // Only required to send ether to the recipient from the initiating external account.
  data:
    '0x7f7465737432000000000000000000000000000000000000000000000000000000600057', // Optional, but used for defining smart contract creation and interaction.
  chainId: '0x3', // Used to prevent transaction reuse across blockchains. Auto-filled by OKX.
};
```



## 四、项目实战

### 1. 铸币项目-代币合约

**铸造**代币。

1.在铸造代币之前，我们需要检查函数的调用者是否是代币的发行者，以确保只有发行者可以随意铸造代币。

2.每次我们铸造代币时，我们都要指定接收代币的账户地址和代币数量。

3.更新所有与金额有关的变量后，铸币就完成了。

https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.17+commit.8df45f5f.js

remix上编译后，部署，就可以选择合约函数进行测试了

```
pragma solidity ^0.8.17;
contract MyToken  {
	//例如这里的myAddress就可以存储和操作以太坊的账户地址
    address private owner;
    
    //mapping类型的变量，用于存储每个地址对应的余额
    mapping (address => uint256) private balances;
    	
    
	//uint256 类型的变量，用于存储 Token 的总发行量。定义为 public，可以被任何人查询。	
    uint256 public totalSupply;
    
    constructor(){
      owner = msg.sender;
    }

    //用于铸造 Token 的函数
    function mint(address recipient, uint256 amount) public {
            // 判断自己作为发行者才能铸币
            require(msg.sender == owner);
            balances[recipient]+=amount;
            totalSupply+=amount;
     }

     // 查询余额
    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
     }
     
      //用于转账的函数
    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(amount <= balances[msg.sender], "Not enough balance.");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        return true;
    }
}
```



#### 真实部署合约

remix选择部署  injected Provider-MetaMask  

metamask必须选择sepolia 测试网络

https://faucets.chain.link/  这个链接链接钱包，先获取link,在获取测试ETH

### 2. 猫咪NFT-**ERC-721**

```
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract SimpleCryptoKitties is ERC721 {
  // 小猫的数量
  uint256 public _tokenIdCounter = 1;

  struct Kitty {
    // 基因
    uint256 genes;
    // 生日
    uint256 birthTime;
    // 猫妈妈的 TokenId
    uint256 momId;
    // 猫爸爸的 TokenId
    uint256 dadId;
    // 迭代数
    uint256 generation;
  }

  mapping(uint256 => Kitty) public kitties;

  constructor() ERC721("SimpleCryptoKitties", "SCK") {}

  // 创建初代小猫
  function createKittyGen0() public returns (uint256) {
    uint256 genes = uint256(
      keccak256(abi.encodePacked(block.timestamp, _tokenIdCounter))
    );
    return _createKitty(0, 0, 0, genes, msg.sender);
  }

  // 创建猫
  function _createKitty(
    uint256 momId,
    uint256 dadId,
    uint256 generation,
    uint256 genes,
    // 猫主人
    address owner
  ) private returns (uint256) {
    kitties[_tokenIdCounter] = Kitty(
      genes,
      block.timestamp,
      momId,
      dadId,
      generation
    );
    // 调用ERC721的函数创建， _tokenIdCounter相当于小猫的ID
    _mint(owner, _tokenIdCounter);
    return _tokenIdCounter++;
  }
  
  // 为了根据指定的猫妈妈和猫爸爸孕育出下一代小猫，而这只小猫的基因与其父母有关
  // 当猫妈和猫爸的主人都是函数的调用者时，才允许孕育新的小猫
   function breed(uint256 momId, uint256 dadId) public returns (uint256) {
    Kitty memory mom = kitties[momId];
    Kitty memory dad = kitties[dadId];
   // 通过 ERC721 的 ownerOf 函数来查询，只需要将 TokenId
    require(ownerOf(momId) == msg.sender, "Not the owner of the mom kitty");
    require(ownerOf(dadId) == msg.sender, "Not the owner of the dad kitty");
    uint256 newGeneration = (mom.generation > dad.generation? mom.generation : dad.generation) + 1;
    uint256 newGenes = (mom.genes + dad.genes) / 2;
    return _createKitty(momId, dadId, newGeneration, newGenes, msg.sender);
  }
}
```

### 3. 众筹质押项目-**ECR-20**

1.**项目发起者**：标识谁启动了众筹活动。

2.**目标金额**：设定的筹资目标，用以衡量众筹成功与否。

3.**活动起始时间**：定义众筹活动开始和结束的具体时间点。

4.**用户质押数目**：记录参与者质押的代币数量。

5.**资金申领状态**：标识项目方是否已经成功申领筹集到的资金。

```
pragma solidity ^0.8.24;

interface IERC20 {
    function transfer(address, uint256) external returns (bool);

    function transferFrom(address, address, uint256) external returns (bool);
}

contract CrowdFund {
    struct Campaign {
        address creator;
        uint256 goal;
        uint256 pledged;
        uint32 startAt;
        uint32 endAt;
        bool claimed;
    }
    // 一个发币中心-类型第一个项目
    IERC20 public immutable token;

    //  **count** 来记录已经发起的众筹活动数量
    uint256 public count;

    // 通过活动 ID 快速访问任何一个特定的众筹活动的详细信息
    mapping(uint256 => Campaign) public campaigns;

    // 双层映射
    // 外层映射：以众筹活动的唯一标识符（活动ID）为键
    //内层映射：以用户的地址为键，质押金额（以代币数量表示）为值
    mapping(uint256 => mapping(address => uint256)) public pledgedAmount;

    constructor(address _token) {
        // ERC20 代币进行资金筹集。因为该代币合约必须实现我们的 IERC20 接口，所以只要有代币合约地址，我们就可以使用 IERC20 来实例化该合约，从而实现与该合约的交互
        token = IERC20(_token);
    }

    // 触发事件来公开宣布新众筹活动的成功创建
    event Launch(
        uint256 id,
        address indexed creator,
        uint256 goal,
        uint32 startAt,
        uint32 endAt
    );

    // 取消触发事件
    event Cancel(uint256 id);

    event Pledge(uint256 indexed id, address indexed caller, uint256 amount);

    event UnPledge(uint256 indexed id, address indexed caller, uint256 amount);

    event Refund(uint256 id, address indexed caller, uint256 amount);

    event Claim(uint256 id);

    // 允许用户创建新的众筹项目  目标金额，开始时间，结束时间
    function launch(uint256 _goal, uint32 _startAt, uint32 _endAt) external {
        require(_startAt >= block.timestamp, "start at < now");
        require(_endAt >= _startAt, "end at < start at");
        require(_endAt <= block.timestamp + 90 days, "end at > max duration");
        count += 1;

        campaigns[count] = Campaign({
            creator: msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: _startAt,
            endAt: _endAt,
            claimed: false
        });
        // 触发时间
        emit Launch(count, msg.sender, _goal, _startAt, _endAt);
    }

    function cancel(uint256 _id) external {
        Campaign memory campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "not creator");
        require(block.timestamp < campaign.startAt, "started");
        delete campaigns[_id];
        emit Cancel(_id);
    }

    // 众筹质押代币
    function pledge(uint256 _id, uint256 _amount) external {
        // storage变量指向区块链的永久存储，任何对storage变量的修改都会直接反映在链上，并且是永久性的。
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp >= campaign.startAt, "not started");
        require(block.timestamp <= campaign.endAt, "ended");
        // 记录活动的总质押金额
        campaign.pledged += _amount;
        // 记录用户的质押金额 双重映射
        pledgedAmount[_id][msg.sender] += _amount;
        token.transferFrom(msg.sender, address(this), _amount);
        // 广播事件
        emit Pledge(_id, msg.sender, _amount);
    }

    // 取消质押，撤销部分或全部资金
    function unpledge(uint256 _id, uint256 _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp <= campaign.endAt, "ended");
        // 更新活动的已筹集金额
        campaign.pledged -= _amount;
        // 更新用户的质押记录
        pledgedAmount[_id][msg.sender] -= _amount;
        // 退还代币给用户
        token.transfer(msg.sender, _amount);
        emit UnPledge(_id, msg.sender, _amount);
    }

    // 提款函数,活动方提取资金
    function claim(uint256 _id) external {
        Campaign storage campaign = campaigns[_id];
        require(campaign.creator == msg.sender, "not creator");
        require(block.timestamp >= campaign.endAt, "not ended");
        require(campaign.pledged >= campaign.goal, "pledged < goal");
        require(!campaign.claimed, "claimed"); // 资金未被提取过

        // 标记资金已被提取
        campaign.claimed = true;
        // 执行资金转移
        token.transfer(campaign.creator, campaign.pledged);
        emit Claim(_id);
    }

    //  退款函数:众筹活动结束却未能达到既定的筹资目标时
    function refund(uint256 _id) external {
        // 存储临时信息, 后续的操作不涉及到活动信息的修改，采用这种方式可以更加节省gas成本。
        Campaign memory campaign = campaigns[_id];
        require(block.timestamp > campaign.endAt, "not ended");
        require(campaign.pledged < campaign.goal, "pledged >= goal");

        // 退款流程
        uint256 bal = pledgedAmount[_id][msg.sender];
        pledgedAmount[_id][msg.sender] = 0;
        token.transfer(msg.sender, bal);
        emit Refund(_id, msg.sender, bal);
    }
}


// 代币合约-自己设置的代币，初始化合约账户就有1000000 ether
contract MockToken is IERC20 {
    string public constant name = "MockToken";
    string public constant symbol = "MCK";
    uint8 public constant decimals = 18;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    uint256 totalSupply_ = 1000000 ether;

    constructor() {
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public view  returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public view  returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= numTokens;
        balances[receiver] += numTokens;
        return true;
    }

    function approve(address delegate, uint256 numTokens) public  returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        return true;
    }

    function allowance(address owner, address delegate) public view returns (uint256) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[owner], "Insufficient balance");
        require(numTokens <= allowed[owner][msg.sender], "Insufficient allowance");

        balances[owner] -= numTokens;
        allowed[owner][msg.sender] -= numTokens;
        balances[buyer] += numTokens;
        return true;
    }
}
```



账号1  两个合约地址 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

用户A 账号2  0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

用户B 账号3  0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db



## 五、funndry

**Foundry** 是一个 Solidity 框架，用于构建、测试、模糊、调试和部署Solidity 智能合约， Foundry 的优势是以 Solidity 作为第一公民，完全使用 Solidity 进行开发与测试，如果你不太熟悉 JavaScript，使用 Foundry 是一个非常好的选择，而且 Foundry 构建、测试的执行速度非常快

●**Forge** 用来进行合约的测试。

●**Cast** 很方便的与合约进行交互，发交易，查询链上数据。

●**Anvil** 可以模拟一个私有节点。

●**Chisel** 可以在命令行快速的有效的实时的写合约，测试合约。



### 5. 框架介绍

#### 5.1 安装

hosts添加

```
# GitHub520 Host Start
140.82.114.25                 alive.github.com
140.82.114.6                  api.github.com
185.199.109.153               assets-cdn.github.com
185.199.111.133               avatars.githubusercontent.com
185.199.111.133               avatars0.githubusercontent.com
185.199.111.133               avatars1.githubusercontent.com
185.199.111.133               avatars2.githubusercontent.com
185.199.111.133               avatars3.githubusercontent.com
185.199.111.133               avatars4.githubusercontent.com
185.199.111.133               avatars5.githubusercontent.com
185.199.111.133               camo.githubusercontent.com
140.82.112.21                 central.github.com
185.199.111.133               cloud.githubusercontent.com
140.82.114.9                  codeload.github.com
140.82.114.21                 collector.github.com
185.199.111.133               desktop.githubusercontent.com
185.199.111.133               favicons.githubusercontent.com
140.82.112.4                  gist.github.com
3.5.0.90                      github-cloud.s3.amazonaws.com
54.231.232.177                github-com.s3.amazonaws.com
52.216.134.227                github-production-release-asset-2e65be.s3.amazonaws.com
16.15.217.244                 github-production-repository-file-5c1aeb.s3.amazonaws.com
52.217.167.97                 github-production-user-asset-6210df.s3.amazonaws.com
192.0.66.2                    github.blog
140.82.113.4                  github.com
140.82.114.17                 github.community
185.199.109.154               github.githubassets.com
151.101.193.194               github.global.ssl.fastly.net
185.199.109.153               github.io
185.199.111.133               github.map.fastly.net
185.199.108.153               githubstatus.com
140.82.112.26                 live.github.com
185.199.111.133               media.githubusercontent.com
185.199.111.133               objects.githubusercontent.com
13.107.42.16                  pipelines.actions.githubusercontent.com
185.199.111.133               raw.githubusercontent.com
185.199.111.133               user-images.githubusercontent.com
140.82.113.21                 education.github.com
185.199.111.133               private-user-images.githubusercontent.com


# Update time: 2025-02-14T14:07:48+08:00
# Update url: https://raw.hellogithub.com/hosts
# Star me: https://github.com/521xueweihan/GitHub520
# GitHub520 Host End

```

```
curl -L https://foundry.paradigm.xyz | bash
```

```
foundryup
```



C:\Users\m1387\.foundry\versions\stable  添加进系统Path

```
forge --version  验证安装成功
```

git.bash 在特定目录下执行添加项目

```
forge init hello_foundry
```

#### 5.2 工程结构

创建好的 Foundry 工程结构为：

```solidity
1> tree -L 2
2.
3├── README.md
4├── foundry.toml
5├── lib
6│   └── forge-std
7├── script
8│   └── Counter.s.sol
9├── src
10│   └── Counter.sol
11└── test
12    └── Counter.t.sol
13
146 directories, 5 files
```

●src：智能合约目录

●script ：部署脚本文件

●lib: 依赖库目录

●test：智能合约测试用例文件夹

●foundry.toml：配置文件，配置连接的网络URL 及编译选项



#### 5.4 cast

**Cast** 是 **Foundry** 用于执行以太坊 RPC 调用的命令行工具。 您可以使用 **Cast** 进行智能合约调用、发送交易或检索任何类型的链数据。

#### 5.5 anvil-部署有用

Anvil 允许开发者在本地环境中运行一个轻量级的以太坊节点，这使得从前端测试智能合约或通过 RPC 接口与合约进行交互变得简单快捷。它是一个理想的工具，特别适合需要频繁迭代和即时反馈的开发过程。

#### 5.6 chisel-了解不看

Chisel 是一个 Solidity REPL（"读取-评估-打印 循环 "的缩写），它允许开发人员编写和测试 Solidity 代码片段。它提供了一个交互式环境，用于编写和执行 Solidity 代码，同时还提供了一组内置命令，用于处理和调试您的代码

动 Chisel 非常简单，只需在命令行中输入 **chisel** 即可。启动后，你可以直接在命令行中编写和测试 Solidity 代码。

### 6. 测试实践-了解

#### 6.1 普通测试

**标准库 Forge Std**

●访问 Hevm：通过**vm**实例，可以直接使用 cheatcodes 来模拟各种区块链状态和行为。

**hevm**是 DappHub 团队开发的以太坊虚拟机（ EVM ）的实现，专门用于测试和调试智能合约。它是一个命令行工具，能够模拟以太坊网络的行为，让开发者在不连接实际以太坊网络的情况下，本地执行、测试和调试他们的智能合约。

●断言与日志记录：继承自 Dappsys Test 的断言功能，以及 Hardhat 风格的日志记录。

●标准库功能：Forge Std 提供的标准库包含各种实用工具和功能，比如将代币发送到指定账户

##### **Forge Std 的标准库**

Forge Std 集成了六个主要的标准库，每个库针对不同的需求提供了专门的功能。

**Std Logs**

Std Logs 基于 DSTest 库中的日志事件功能进行了扩展，提供了更丰富的日志记录选项。

**Std Assertions**

Std Assertions 对 DSTest 库中的断言函数进行了扩展，增强了断言功能。

**Std Cheats**

Std Cheats 为 Forge cheatcodes 提供了安全的封装，改善了开发体验。通过在测试合约中调用它们，可以轻松实现身份伪装、账户余额设置等操作。

**Std Errors**

Std Errors 提供了对常见 Solidity 错误和回退的封装，与 expectRevert cheatcode 结合使用时，无需记住 Solidity 内部的 panic 代码。

**Std Storage**

Std Storage 简化了合约存储的操作，使得查找和修改特定变量的存储位置变得简单直接。

**Std Math**

Std Math 库提供了 Solidity 中未提供的有用数学函数，为开发者提供了更多的数学运算支持

##### 作弊码 VM

在智能合约的开发过程中，仅仅测试合约的输出通常是不够的。我们还需要能够操纵区块链的状态，测试特定的还原操作和事件。Foundry 通过作弊码为开发者提供了这样的能力，从而使测试更加全面和精确。





##### **setUp函数**

**setUp**是一个可选函数，会在每个测试用例运行前被调用，用于初始化测试环境：

```solidity
1function setUp() public {
2    // 初始化代码
3}
```

##### **test函数**

以**test**为前缀的函数会被识别为测试用例并执行：

```solidity
1function test_MyFunctionality() public {
2    // 断言和测试逻辑
3}
```

##### **testFail函数**

与**test**前缀相反，**testFail**用于标识一个预期失败的测试。如果该函数没有触发revert，则测试失败：

```solidity
1function testFail_MyFailingCase() public {
2    // 预期失败的测试逻辑
3}
```

##### **运行指定测试**

我们可以通过传递过滤条件来运行特定的测试用例或合约：

```shell
1$ forge test --match-contract ComplicatedContractTest --match-test test_Deposit
```

此命令将仅运行名为**ComplicatedContractTest**的测试合约中包含**test_Deposit**的测试函数。

##### forge-test

```
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
}
```

我们可以通过如下三种方式执行测试用例：

●forge test 命令，可以一键把所有的test包下的测试用例都测试一遍。执行后，在命令行中会打印出 forge 测试的结果(通过与否)，错误的原因，以及执行的耗时。

●forge test --match-path test/Counter.t.sol 命令，使用 --match-path 来指定**某一路径下的文件**来进行测试。

●forge test --match-contract CounterTest --match-test test_Increment 命令，用 --match-contract 来指定测试**合约的名称**，其中 --match-test 用来指定调用的**测试方法**。

注意：--match-path 后跟的是文件名，而 --match-contract 后面跟的是合约名，填写参数时要注意匹配条件是否正确。



forge test 等同于 forge test -v ，会打印测试方法中的gas消耗

**Level2(**-vv**)** 会打印出测试中的日志，断言，预期结果，错误原因，这些更详尽的信息。

●**Level3(**-vvv**)**  会打印出测试失败中的失败堆栈调用。

●**Level4(**-vvvv**)** 不仅会打印失败结果的堆栈调用，会把所有的测试中的堆栈调用，全部打印出来。

●**Level5(**-vvvvv**)**  始终显示堆栈跟踪和设置跟踪。还显示了对象的创建，每一步的具体分析。

### 7. 项目实战-创建NFT

#### 7.1 安装

使用fundry创建项目，git必须是干净的，commit完，然后

**lib/solmate**: 存放了 Solmate 库的文件，这是一个专为节省 gas 而优化的 ERC721 标准实现。

●**lib/openzeppelin-contracts**: 包含了 OpenZeppelin 提供的智能合约库，这些库广泛用于提供安全性和遵循最佳实践的智能合约开发。

```
forge install transmissions11/solmate Openzeppelin/openzeppelin-contracts
```

#### 7.2 部署

```
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "solmate/tokens/ERC721.sol";
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";

contract NFT is ERC721 {
    uint256 public TokenId = 1;

    constructor(string memory  _name, string memory  _symbol) ERC721(_name, _symbol) {}

    // 这个函数用于提供有关 NFT 的详细信息的元数据的链接。遵循这个标准可以确保你的 NFT 合约能够与广泛的市场、钱包和其他接口兼容
    function tokenURI(
        uint256 id
    ) public view virtual override returns (string memory) {
        // 模拟URL tokenURI 函数内将 token ID 转换为字符串形式以构造完整的 URI
        return Strings.toString(id);
    }

    // 制造代币 mintTo 函数拥有一个地址参数，表示接收 NFT 的地址  payable：允许该函数接收以太币
    function mintTo(address recipient) public payable returns (uint256) {
        uint256 newItemId = ++TokenId;
        _safeMint(recipient, newItemId);
    }
}
```

将test/script 的代码注释掉，只留下solidity版本号



##### 启动测试环境

**接着执行avail，启动测试环境，需要另开个窗口保持着**



执行这个 <你的钱包私钥选一个>

```
export RPC_URL=http://127.0.0.1:8545/
export PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

##### 部署合约

```
forge create NFT --rpc-url=$RPC_URL --private-key=$PRIVATE_KEY --constructor-args <name> <symbol>

forge create NFT --rpc-url=$RPC_URL --private-key=$PRIVATE_KEY --constructor-args "Dog" "Lin"
```

部署后，合约部署地址 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266

```
from: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266   固定的
```



##### 铸造币

contractAddress ：部署的合约地址，0xf39Fd6e51aad88F6F4ce6aB8827279cffFb9226

mintAddress ：则可以从 anvil 提供的 Available Accounts 选择一个即可。

```
cast send --rpc-url=$RPC_URL <contractAddress to>  "mintTo(address)" <mintAddress from> --private-key=$PRIVATE_KEY

cast send --rpc-url=$RPC_URL "0x5FbDB2315678afecb367f032d93F642f64180aa3"  "mintTo(address)" "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266" --private-key=$PRIVATE_KEY


cast send --rpc-url=$RPC_URL "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"  "mintTo(address)" "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266" --private-key=$PRIVATE_KEY
```



##### 查看NFT持有者所属地址

```
cast call --rpc-url=$RPC_URL --private-key=$PRIVATE_KEY <contractAddress> "ownerOf(uint256)" 1

cast call --rpc-url=$RPC_URL --private-key=$PRIVATE_KEY "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266" "ownerOf(uint256)" 1

cast call --rpc-url=$RPC_URL --private-key=$PRIVATE_KEY "0x5FbDB2315678afecb367f032d93F642f64180aa3" "ownerOf(uint256)" 1
```



