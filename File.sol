pragma solidity 0.5.1;


contract IPayYouForThings{
    enum State { Waiting, Active, Ready }
    State public state;
    address owner;
    uint256 public peopleCount = 0;
    mapping(uint => Person) private people;
    mapping(address => uint256) private balances;
    address payable wallet;
    string public states = "0.Waiting |  1.Active  |2.Ready";
    MyLittleMarket mlmadd;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    constructor(address payable _wallet) public {
        owner = msg.sender;
        wallet = _wallet;
        state = State.Waiting;
    }
    
    function activate() public onlyOwner{
        if (state == State.Ready)
        {
            state = State.Waiting;
        }
        else
        {
            state = State.Ready;
        }
    }

    function isActive() private view returns(bool) {
        if (state == State.Ready)
        {
            return state == State.Ready;
        }
        else if (state == State.Waiting)
        {
            return state == State.Waiting;
        }
        else
        {
            return state == State.Active;
        }
        
    }
    
    
      struct Person {
        uint _id;
        string public_firstName;
        string _lastName;
    }
    
    function addPerson (
        string memory _firstName,
        string memory _lastName
    )
        private
    {
        incrementCount();
        people[peopleCount] = Person(peopleCount, _firstName, _lastName);
    }

    function incrementCount() internal {
        peopleCount += 1;
    }
    
    
     event Purchase(
        address indexed _buyer,
        uint256 _amount
    );


    function() external payable {
        Email();
        Paypal();
        Tool();
    }

    function Email() public payable onlyOwner{
        if(state == State.Ready)
        {
            state = State.Active;
            balances[msg.sender] += 1;
            //wallet.transfer(msg.value);
            emit Purchase(msg.sender, 5);
            state = State.Ready;
        }
    }
    
    function Paypal() public payable onlyOwner {
        if(state == State.Ready)
        {
            state = State.Active;
            balances[msg.sender] += 3;
            // wallet.transfer(msg.value);
            emit Purchase(msg.sender, 3);
            state = State.Ready;
        }
    }
    
    function Tool() public payable onlyOwner {
        if(state == State.Ready)
        {
            state = State.Active;
            balances[wallet] += 5;
            balances[msg.sender] -= 5;
            //wallet.transfer(msg.value);
           // msg.sender.transfer(msg.value);
            emit Purchase(wallet, 5);
            state = State.Ready;
        }
    }
    
    function SocialProfile (
        string memory _firstName,
        string memory _lastName
    )
        public payable onlyOwner
    {
        if(state == State.Ready)
        {
            state = State.Active;
            addPerson(_firstName, _lastName);
            balances[msg.sender] += 10;
            //wallet.transfer(msg.value);
            emit Purchase(msg.sender, 10);
            state = State.Ready;
        }
    }
    
}

contract MyLittleMarket {
    enum State { Waiting, Active, Ready }
    State private state;
    /*
    uint256 public peopleCount = 0;
    mapping(uint => Person) public people;
    */
    mapping(address => uint256) private balances;
    address payable wallet;
    address owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    struct Person {
        uint _id;
        string public_firstName;
        string _lastName;
    }

    constructor(address payable _wallet) public {
        owner = msg.sender;
        //wallet = _wallet;
        wallet = _wallet;
        state = State.Waiting;
    }
    
    event Purchase(
        address indexed _buyer,
        uint256 _amount
    );


    function() external payable {
        buyEmail_1ether();
        buyPaypal_2ether();
        buyTool_5ether();
        buySocialProfile_3ether();
    }

    function buyEmail_1ether() public payable {
        require(msg.value == 1, "The donation needs to be =1 in order for it to go through");
        if(state == State.Ready)
        {
            state = State.Active;
            if ( balances[msg.sender] < 1)
            { 
                return;
            }
            else
            {
                balances[msg.sender] += 1;
                wallet.transfer(msg.value);
                emit Purchase(msg.sender, 1);
            }
            state = State.Ready;
        }
    }
    
    function buyPaypal_2ether() public payable {
        require(msg.value == 2, "The donation needs to be =2 in order for it to go through");
        if(state == State.Ready)
        {
            state = State.Active;
            if ( balances[msg.sender] < 3)
            { 
                return;
            }
            else
            {
                balances[msg.sender] += 3;
                wallet.transfer(msg.value);
                emit Purchase(msg.sender, 3);
            }
            state = State.Ready;
        }
    }
    
    function buyTool_5ether() public payable {
        require(msg.value == 5, "The donation needs to be = 5 in order for it to go through");
        if(state == State.Ready)
        {
            state = State.Active;
            if ( balances[msg.sender] < 5)
            { 
                return;
            }
            else
            {
                balances[msg.sender] += msg.value;
                wallet.transfer(msg.value);
                emit Purchase(msg.sender, msg.value);
            }
            state = State.Ready;
        }
    }
    
    function buySocialProfile_3ether (
    )
        public payable
    {
        require(msg.value == 3, "The donation needs to be =3 in order for it to go through");
        if(state == State.Ready)
        {
            state = State.Active;
            if ( balances[msg.sender] < 2)
            { 
                return;
            }
            else
            {
                balances[msg.sender] += 2;
                wallet.transfer(msg.value);
                emit Purchase(msg.sender, 10);
            }
            state = State.Ready;
        }
    }
}
