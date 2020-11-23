pragma solidity ^0.5.16;

contract Context {
    constructor () internal { }

    /**
     * 内部函数_msgSender，获取函数调用者地址
     */
    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }
}