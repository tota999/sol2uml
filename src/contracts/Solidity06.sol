pragma solidity ^0.6.0;

enum Locations {
    Continent,
    Empire,
    Union,
    Country,
    State,
    City,
    Council,
    Village
}

struct KeyValuePair {
    string name;
    int256 value;
}

struct GlobalBaseStruct {
    KeyValuePair[] pairs;
    Locations location;
}

contract VirtualA {
    GlobalBaseStruct base;
    event MyEvent(string _myString);
    function funA() public virtual {
        emit MyEvent("from A");
    }
}

contract VirtualB {
    function funA() public virtual {
        //does nothing
    }
}

contract VirtualOverdide is VirtualA, VirtualB {
    function funA() public override(VirtualB,VirtualA) {
        emit MyEvent("from B");
        super.funA();
    }
}

contract ArrayFunctions {
    uint[] public myUintArray;
    
    function add(uint _num) public {
        myUintArray.push(_num);
    }
    
    function removeElement() public {
        myUintArray.pop();
    }
}

contract FallbackReceive {
    event SomeEvent(address _addr, uint _amount);
    
    /**
     * Will be called when (fallback) is used in Remix
     */
    receive() external payable {
        emit SomeEvent(msg.sender, msg.value);
    }
    
    /**
     * Will be called when msg.data is not empty or when receive() doesn't exist
     * 
     * If not payable => revert-style error on msg.value not empty
     * */
    fallback () external {
        
    }
}

contract TryBaseBase {
    function funARequireFailure() public pure {
        require(false, "This is an error String");
    }
    
    function funBRevertFailure() public pure {
        revert("Error from Contract A");
    }
    
    function funCAssertFailure() public pure {
        assert(false);
    }
}

contract TryCatch {
    TryBaseBase instA;
    
    event Error(string _reason);
    event LowLevelError(bytes _reason);
    
    constructor() public {
        instA = new TryBaseBase();
    }
    
    function testRequireTryCatch() public returns(bool) {
        try instA.funCAssertFailure() {
            return true;
        } catch Error(string memory reason) {
            // This is executed in case
            // revert was called inside getData
            // and a reason string was provided.
            emit Error(reason);
            return false;
        } catch (bytes memory lowLevelData) {
            // This is executed in case revert() was used
            // or there was a failing assertion, division
            // by zero, etc. inside getData.
            emit LowLevelError(lowLevelData);
            return false;
        }
    }
}
