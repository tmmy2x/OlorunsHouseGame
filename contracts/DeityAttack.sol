pragma solidity >=0.5.0 <0.6.0;

import "./OlorunsHelper.sol";

contract DeityAttack is OlorunsHelper {
    uint randNonce = 0;

    uint attackVictoryProbability = 70;

    function randMod(uint _modulus) internal returns(uint) {
        randNonce = randNonce.add(1);
        return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;  
    }

    function attack(uint deityId, uint targetId) external onlyOwnerOf(deityId) {
        Deity storage myDeity = deities[_deityId];
        Deity storage enemyDeity = deities[_targetId];
        uint rand = randMod(100);
        if (rand <= attackVictoryProbability) {
          myDeity.winCount = myDeity.winCount.add(1);
          myDeity.level = myDeity.level.add(1);
          enemyDeity.lossCount = enemyDeity.lossCount.add(1);
          growAndMultiply(_deityId, enemyDeity.dna, "deity");
        } else {
          myDeity.lossCount = myDeityossCount.add(1);
          enemyDeity.winCount = enemyDeity.winCount.add(1);
          _triggerCooldown(myDeity);
        }   
    } 
}
