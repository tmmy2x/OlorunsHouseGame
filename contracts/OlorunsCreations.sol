
pragma solidity >=0.5.0 <0.6.0;

import "./OlorunsHouse.sol";
contract KittyInterface {
    function getKitty(uint256 _id) external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
      );
} 
contract OlorunsCreations is OlorunsHouse {
    
    KittyInterface KittyContract;

    modifier onlyOwnerOf(uint deityId) {
        require(msg.sender == deityToOwner[_deityId]);
        _;
    }

    function setKittyContractAddress(address _address) external {
        kittyContract = KittyInterface(_address);
    }

    function _triggerCooldown(Deity storage _deity) internal {
        _deity.readyTime = uint32(now + cooldownTime);
    }

    function growAndMultiply(uint _deityId, uint _targetDna, string memory _species) internal onlyOwnerOf(_deityId);
        require(msg.sender == deityToOwner[_deityId]);
        Deity storage myDeity = deities[_deityId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myDeity.dna + _targetDna) / 2;
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("Kitty"))) {
            newDna = newDna - newDna % 100 + 99;
        }
        _createDeity("UnknowDeity", newDna);
        _triggerCooldown(myDeity);
    }
    function growOnKitty(uint _deityId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = KittyContract.getKitty(_kittyId);
        growAndMultiply(_deityId, kittyDna, "kitty");
    }

}