
pragma solidity >=0.5.0 <0.6.0;

import "./ownable.sol";
import "./safemath.sol";

contract OlorunsHouse is Ownable {
    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;        
            
    event NewDeity(uint deityId, string name, uint dna);
            
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Deity {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    Deity[] public deities;

    mapping (uint => address) public deityToOwner;
    mapping (address => uint) ownerDeityCount;

    function createDeity(string _name, uint dna) internal {
        uint id = deities.push(Deity(_name, _dna, 1, uint32(now + cooldownTime)0, 0, 0)) - 1;
        deityToOwner[id] = msg.sender;
        ownerDeityCount[msg.sender] = ownerDeityCount[msg.sender].add(1);
        emit NewDeity(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint){
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomDeity(string _name) public {
        require(ownerDeityCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createDeity(_name, randDna);
    }
        
}
