pragma solidity ^0.8.0;

// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";



/// @title A title that should describe the contract/interface
/// @author The name of the author
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details

contract Token is ERC20 {
  address public admin;
    constructor() ERC20("For Mocacenko Token", "FMT") {
    _mint(msg.sender, 1000*10**18);
    admin = msg.sender;
    
  }

}