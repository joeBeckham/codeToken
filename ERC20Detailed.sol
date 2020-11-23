pragma solidity ^0.5.16;

import './IERC20.sol';

contract ERC20Detailed is IERC20 {

    string private _name;  // 代币的名字
    string private _symbol; // 代币的简称
    uint8 private _decimals; // 代币的精度，例如：为2的话，则精确到小数点后面两位

    /**
     * 构造函数
     */
    constructor (string memory name, string memory symbol, uint8 decimals) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
    }
    
    /** 
     * 获取代币的名称
     */
    function name() public view returns (string memory) {
        return _name;
    }

    /** 
     * 获取代币的简称
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /** 
     * 获取代币的精度
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }
}