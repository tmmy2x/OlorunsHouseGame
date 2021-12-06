
pragma solidity >=0.5.0 <0.6.0;

import "./OlorunsCreations.sol";

contract OlorunsHelper is OlorunsCreations {

  uint levelUpFee = 0.002 ether;  

  modifier aboveLevel(uint _level, uint _deityId) {
    require(deities[_deityId].level >= _level);
    _;
  }

  function withdraw() external onlyOwner {
    address payable _owner = address(uint160(owner()));
    _owner.transfer(address(this).balance);
  }

  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }


  function levelUp(uint _deityId) external payable {
      require(msg.value = levelUpFee);
      deities[_deityId].level = deities[_deityId].level.add(1);
  }

  function changeName(uint _deityId, string calldata _newName) external aboveLevel(2, _deityId) onlyOwnerOf(deityId) {
    require(msg.sender == deityToOwner[_deityId]);
    deities[_deityId].name = _newName;
  }

  function changeDna(uint _deityId, uint _newDna) external aboveLevel(20, _deityId) onlyOwnerOf(deityId) {
    require(msg.sender == deityToOwner[_deityId]);
    deities[_deityId].dna = _newDna;
  }

  function getDeitiesByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerDeityCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < deities.length; i++) {
      if (deityToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}