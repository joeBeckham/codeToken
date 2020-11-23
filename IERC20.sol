pragma solidity ^0.5.16;

/**
 * 定义ERC20 Token标准要求的接口函数
 */
interface IERC20 {

    /**
     * token总量
     */
    function totalSupply() external view returns (uint);

    /**
     * 某个地址的余额
     */
    function balanceOf(address account) external view returns (uint);

    /**
     * 转账
     * @param recipient 接收者
     * @param amount    转账金额
     */
    function transfer(address recipient, uint amount) external returns (bool);

    /**
     * 获取_spender可以从账户_owner中转出token的剩余数量
     */
    function allowance(address owner, address spender) external view returns (uint);

    /**
     * 批准_spender能从合约调用账户中转出数量为_value的token
     * @param spender 授权给的地址
     * @param amount  金额
     */
    function approve(address spender, uint amount) external returns (bool);

    /**
     * 代理转账函数，调用者代理代币持有者sender向指定地址recipient转账一定数量amount代币
        （用于允许合约代理某人转移token。条件是sender账户必须经过了approve）
     * @param sender    转账人
     * @param recipient 接收者
     * @param amount    转账金额
     */
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);

    /**
     * 发生转账时必须要触发的事件，transfer 和 transferFrom 成功执行时必须触发的事件
     */
    event Transfer(address indexed from, address indexed to, uint value);

    /**
     * 当函数approve 成功执行时必须触发的事件
     */
    event Approval(address indexed owner, address indexed spender, uint value);
}