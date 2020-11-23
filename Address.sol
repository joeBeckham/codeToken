pragma solidity ^0.5.16;

/**
 * Address库定义isContract函数用于检查指定地址是否为合约地址
 */
library Address {

    /**
     * 判断是否是合约地址
     */
    function isContract(address account) internal view returns (bool) {
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != 0x0 && codehash != accountHash);
    }
}