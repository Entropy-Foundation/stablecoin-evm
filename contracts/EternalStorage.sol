pragma solidity ^0.4.18;

/// @title The primary persistent storage for Rocket Pool
/// @author David Rugendyke with modifications by CENTRE. 

contract EternalStorage {

    address owner;
    mapping(address => bool) private access;
    bool private initialized = false;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowed;
    uint256 private totalSupply = 0;
    mapping(address => bool) private redeemers;
    mapping(address => bool) private blacklisted;
    mapping(address => bool) private minters;
    mapping(address => uint256) private minterAllowed;

    function EternalStorage() public {
        owner = msg.sender;
    }

    /*** Modifiers ************/

    /// @dev Only allow access from the latest version contract after initialization
    modifier onlyAuthorizedContracts() {
        // The owner is only allowed to set the storage upon deployment to register the initial contracts, afterwards their direct access is disabled
        if (initialized == false) {
            require(msg.sender == owner);
        } else {
            // Make sure the access is permitted to only contracts in our Dapp
            require(access[msg.sender] != false);
        }
        _;
    }

    /**** Get Methods ***********/

    function getInitialized() external view returns (bool) {
        return initialized;
    }

    function getAccess(address _address) external view returns (bool) {
        return access[_address];
    }

    function getAllowed(address _from, address _spender) external view returns (uint256) {
        return allowed[_from][_spender];
    }

    function getBalance(address _account) external view returns (uint256) {
        return balances[_account];
    }

    function getTotalSupply() external view returns (uint256) {
        return totalSupply;
    }

    function isRedeemer(address _account) external view returns (bool) {
        return redeemers[_account];
    }

    function isBlacklisted(address _account) external view returns (bool) {
        return blacklisted[_account];
    }

    function getMinterAllowed(address _minter) external view returns (uint256) {
        return minterAllowed[_minter];
    }

    function isMinter(address _account) external view returns (bool) {
        return minters[_account];
    }


    /**** Set Methods ***********/

    function setInitialized(bool _status) onlyAuthorizedContracts external {
        initialized = _status;
    }

    function setAccess(address _address, bool _status) onlyAuthorizedContracts external {
        access[_address] = _status;
    }

    function setAllowed(address _from, address _spender, uint256 _amount) onlyAuthorizedContracts external {
        allowed[_from][_spender] = _amount;
    }

    function setBalance(address _account, uint256 _amount) onlyAuthorizedContracts external {
        balances[_account] = _amount;
    }

    function setTotalSupply(uint256 _totalSupply) onlyAuthorizedContracts external {
        totalSupply = _totalSupply;
    }

    function setRedeemer(address _account, bool _status) onlyAuthorizedContracts external {
        redeemers[_account] = _status;
    }

    function setBlacklisted(address _account, bool _status) onlyAuthorizedContracts external {
        blacklisted[_account] = _status;
    }

    function setMinterAllowed(address _minter, uint256 _amount) onlyAuthorizedContracts external {
        minterAllowed[_minter] = _amount;
    }

    function setMinter(address _account, bool _status) onlyAuthorizedContracts external {
        minters[_account] = _status;
    }

}