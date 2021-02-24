pragma solidity ^0.6.0;

contract vaccine{
    address public owner;
    bool public pause;
    constructor() public{
        owner = msg.sender;
    }
    struct Despatch{
            uint qty;
            uint timestamp;
    }
    struct Authenticate{
        uint totbatch;
        uint numpay;
        uint time;
        mapping(uint => Despatch) batch;
    }
    mapping(address => Authenticate)public verify_record;
    event sentmoney(address indexed add1,uint amt1);
    event recmoney(address indexed add2,uint amt2);
    modifier onlyOwner(){
        require(msg.sender == owner,"You are not the owner");
        _;
    }
    modifier whilenotpaused(){
        require(pause == false,"Sc is paused");
        _;
    }
    function change(bool ch)public onlyOwner{
        pause = ch;
    }
    function add_Batch()public payable whilenotpaused {
        verify_record[msg.sender].totbatch += msg.value;
        verify_record[msg.sender].numpay += 1;
        verify_record[msg.sender].time=now;
        Despatch memory pay = Despatch(msg.value,now);
        verify_record[msg.sender].batch[verify_record[msg.sender].numpay] = pay;
        
        emit sentmoney(msg.sender,msg.value);
    }
    function get_Batch()public view whilenotpaused returns(uint){
        return verify_record[msg.sender].totbatch ;
    }
   function Time_call()public view returns (uint256){
        return verify_record[msg.sender].time;
    }
    
    function check_Vacchine()public view returns(string memory){
        if(verify_record[msg.sender].time > 1614109728){
            return "Vaccine is safe to use";
        }
        else{
            return "Vaccine has been expired";
        }
    }
