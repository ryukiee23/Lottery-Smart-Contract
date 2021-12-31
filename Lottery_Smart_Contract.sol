pragma solidity ^0.5.3;

contract lottery{

address public owner;
address payable[] public participants;
address payable public winner;

constructor()public{
    owner = msg.sender;
}
modifier OwnerOnly{
    if(msg.sender==owner){
    _;
    }
}

function deposit() public payable{
    require(msg.value >=1 ether);
    participants.push(msg.sender);
}

function randomgenerate()public view returns(uint){
    return uint(keccak256(abi.encodePacked(block.difficulty,now,participants.length)));
}

function pickwinner()public OwnerOnly {
    uint random = randomgenerate();
    uint index = random % participants.length;
    
    
    winner = participants[index];
    winner.transfer(address(this).balance);
    participants = new address payable [] (0);
}
}
