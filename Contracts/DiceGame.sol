pragma solidity ^0.5.1;

contract DiceGame{
    
    string public name;
    string public symbol;
    uint8 public decimals = 8;
    uint256 public totalsupply;
    
    mapping (address => uint256) public balanceOf;
    
    uint256 public player_count;
    uint256 player1_amount;
    uint256 player1_diceresult;
    
    address player1_address;
    address owner;
    
    uint256 initSupply = 1000000;
    string tokenName = "kylecoin";
    string tokenSymbol = "KC";
    
    constructor () public {
        
        totalsupply = initSupply*10**uint256(decimals);
        balanceOf[msg.sender] = totalsupply;
        name = tokenName;
        symbol = tokenSymbol;
        
        owner = msg.sender;
        
    }
    
    function _transfer(address _from, address _to, uint _value) internal{
        require(_to != address(0));
        require(balanceOf[_from] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        
        uint256 pervouisBalance = balanceOf[_from] + balanceOf[_to];
        
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        
        assert(balanceOf[_from] + balanceOf[_to] == pervouisBalance);
        
    }
    
    function transfer(address _to, uint256 _value) public returns (bool success){
        
        _transfer(msg.sender, _to, _value);
        return true;
        
    }
    
    function placeBet(uint256 _value, uint256 _diceresult) public returns(bool success) {
        
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[owner] += _value;
        
        player_count += 1;
        
        if(player_count == 1) {
            
            player1_diceresult = _diceresult;
            player1_amount = _value;
            player1_address = msg.sender;
            
        }
        
        if(player_count == 2) {
            
            if (player1_diceresult == _diceresult) {
                balanceOf[player1_address] += player1_amount;
                balanceOf[msg.sender] += _value;
                balanceOf[owner] -= player1_amount;
                balanceOf[owner] += _value;
                
            }
            
            if (player1_diceresult > _diceresult) {
                balanceOf[player1_address] += player1_amount;
                balanceOf[player1_address] += _value;
                balanceOf[owner] -= player1_amount;
                balanceOf[owner] += _value;
                
            }
            
            if (player1_diceresult < _diceresult) {
                balanceOf[msg.sender] += player1_amount;
                balanceOf[msg.sender] += _value;
                balanceOf[owner] -= player1_amount;
                balanceOf[owner] += _value;
                
            }
            
            player1_amount = 0;
            player_count = 0;
            player1_diceresult = 0;
            player1_address == address(0);
            
        }
        
    }
}


