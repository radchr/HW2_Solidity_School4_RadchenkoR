
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/////////////////////////////////////////////////
contract Contract {
    //TODO -- impruve - start.
    mapping(address => uint256) public ethBL;

    mapping(address => mapping(address => uint256)) public tokenBL;
    
    mapping(address => bool) public tk_in;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    
//FUNCTIONS
    function deposit() external payable returns(bool){
        ethBL[msg.sender] += msg.value;
        return(true);

    }
//______________________________________
    function getOwner() public pure returns(string memory) {
        return("GET OWNER");
            }
//________________________________________________________________
    function up_token(address _token, bool _in) external onlyOwner returns(bool) {
        tk_in[_token] = _in;
        return(true);
    }
//__________________________________________________________________
    function depositToken(address _token, uint256 _amount) external {
        require(tk_in[_token], "Token is not allowed for deposit");

        uint256 _balanceBefore = IERC20(_token).balanceOf(address(this));

        bool success = IERC20(_token).transferFrom(
            msg.sender,
            address(this),
            _amount
        );
        require(success, "Deposit -- ERROR");

        uint256 _balanceAfter = IERC20(_token).balanceOf(address(this));

        require(_balanceAfter >= _balanceBefore, "token transfer is not corect");
        tokenBL[msg.sender][_token] += _balanceAfter - _balanceBefore;
    }
//________________________________________________________________________
    function withdraw(uint256 _amount, address _to) external {
        require(ethBL[msg.sender] >= _amount, "eth - is not enought  balance");
        ethBL[msg.sender] -= _amount;
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Withdraw ERROR");
    }
//_______________________________________________________ 
    function withdrawToken(
        address _token,
        uint256 _amount,
        address _to
    ) external {
        require(
            tokenBL[msg.sender][_token] >= _amount,
            "Not enought token balance"
        );
        tokenBL[msg.sender][_token] -= _amount;
        bool success = IERC20(_token).transfer(_to, _amount);
        require(success, "Withdraw -- ERROR");
    }
}
