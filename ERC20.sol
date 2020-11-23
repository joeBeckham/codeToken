pragma solidity ^0.5.16;

import './SafeMath.sol';
import './Context.sol';
import './IERC20.sol';

contract ERC20 is Context, IERC20 {

    // 引入SafeMath安全数学运算库，避免数学运算整型溢出
    using SafeMath for uint;

    // 用mapping保存每个地址对应的余额
    mapping (address => uint) private _balances;

    // 存储对账号的控制 
    mapping (address => mapping (address => uint)) private _allowances;

    // 总供应量
    uint private _totalSupply;

    /**
     * 获取总供应量
     */
    function totalSupply() public view returns (uint) {
        return _totalSupply;
    }

    /**
     * 获取某个地址的余额
     */
    function balanceOf(address account) public view returns (uint) {
        return _balances[account];
    }

    /**
     * 转账
     */
    function transfer(address recipient, uint amount) public returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     *  获取被授权令牌余额,获取 _owner 地址授权给 _spender 地址可以转移的令牌的余额
     */
    function allowance(address owner, address spender) public view returns (uint) {
        return _allowances[owner][spender];
    }

    /**
     * 授权，允许 spender 地址从你的账户中转移 amount 个令牌到任何地方
     */
    function approve(address spender, uint amount) public returns (bool) {
        // 调用内部函数_approve设置调用者对spender的授权值
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * 代理转账函数，调用者代理代币持有者sender向指定地址recipient转账一定数量amount代币
     */
    function transferFrom(address sender, address recipient, uint amount) public returns (bool) {
        // 调用内部函数_transfer进行代币转账
        _transfer(sender, recipient, amount);
        // 调用内部函数_approve更新转账源地址sender对调用者的授权值
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    /**
     * 增加授权值函数，调用者增加对spender的授权值
     */
    function increaseAllowance(address spender, uint addedValue) public returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    /**
     * 减少授权值函数，调用者减少对spender的授权值
     */
    function decreaseAllowance(address spender, uint subtractedValue) public returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    /**
     * 转账
     */
    function _transfer(address sender, address recipient, uint amount) internal {
        // 非零地址检查
        require(sender != address(0), "ERC20: transfer from the zero address");
        // 非零地址检查，避免转账代币丢失
        require(recipient != address(0), "ERC20: transfer to the zero address");
        // 修改转账双方地址的代币余额
        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        // 触发Transfer事件
        emit Transfer(sender, recipient, amount);
    }

    /**
     * 铸币
     */
    function _mint(address account, uint amount) internal {
        // 非零地址检查
        require(account != address(0), "ERC20: mint to the zero address");
        // 更新代币总量
        _totalSupply = _totalSupply.add(amount);
        // 修改代币销毁地址account的代币余额
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    /**
     * 代币销毁
     */
    function _burn(address account, uint amount) internal {
        // 非零地址检查
        require(account != address(0), "ERC20: burn from the zero address");
        // 修改代币销毁地址account的代币余额
        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        // 更新代币总量
        _totalSupply = _totalSupply.sub(amount);
        // 触发Transfer事件
        emit Transfer(account, address(0), amount);
    }

    /**
     * 批准_spender能从合约调用账户中转出数量为amount的token
     */
    function _approve(address owner, address spender, uint amount) internal {
        // 非零地址检查
        require(owner != address(0), "ERC20: approve from the zero address");
        // 非零地址检查
        require(spender != address(0), "ERC20: approve to the zero address");
        // 设置owner对spender的授权值为amount
        _allowances[owner][spender] = amount;
        // 触发Approval事件
        emit Approval(owner, spender, amount);
    }
}