// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "openzeppelin-solidity/contracts/token/ERC20/utils/SafeERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "openzeppelin-solidity/contracts/access/AccessControlEnumerable.sol";

contract Vault is Ownable, AccessControlEnumerable {
    IERC20 public token;
    uint256 public maxWithdrawAmount;
    bool public withdrawEnable;
    bytes32 public constant WITHDRAWER_ROLE = keccak256("WITHDRAWER_ROLE");

    function setWithDrawEnable(bool _isEnable) public onlyOwner {
        withdrawEnable = _isEnable;
    }

    function setMaxWithDrawAmount(uint256 _maxAmount) public onlyOwner {
        maxWithdrawAmount = _maxAmount;
    }

    function setToken(IERC20 _token) public onlyOwner {
        token = _token;
    }

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    function withDraw(uint256 _amount, address _to) external onlyWithDrawer {
        require(withdrawEnable, "WithDraw is not available");
        require(_amount <= maxWithdrawAmount, "Exceed maximun amount");
        token.transfer(_to, _amount);
    }

    function deposit(uint256 _amount) external {
        require(
            token.balanceOf(msg.sender) >= _amount,
            "Insufficient account balance"
        );
        SafeERC20.safeTransferFrom(token, msg.sender, address(this), _amount);
    }

    modifier onlyWithDrawer() {
        require(
            owner() == _msgSender() || hasRole(WITHDRAWER_ROLE, _msgSender()),
            "Caller is not a withdrawer"
        );
        _;
    }
}
