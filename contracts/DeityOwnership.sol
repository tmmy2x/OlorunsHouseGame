pragma solidity =>0.5.0 <0.6.0;

import "./DeityAttack.sol";
import "./erc721.sol";
import "./safemath.sol";

/** 
 * @title This contract manages transfering deity ownership
 * @auther Tim Marshall aka tmmy2x
 * @dev Compliant with OpenZeppelin's implementation of the ERC721 spec draft
 */
contract DeityOwnership is DeityAttack, ERC721 {
    
    using SafeMath for uint256;
    
    mapping (uint => address) deityApprovals;
    
    function balanceOf(address _owner) external view returns (uint256) {
        return ownerDeityCount[_owner];
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        return deityToOwner[_tokenId];
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownerDeityCount[_to] = ownerDeityCount[_to].add(1);
        ownerDeityCount[_from] = ownerDeityCount[_from].sub(1);
        deityToOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        require (deityToOwner[_tokenId] == msg.sender || zombieApprovals [_tokenId] == msg.sender);
        _transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
        deityApprovals[_tokenId] = _approved;
        emit Approval(msg.sender, _approved, _tokenId);
    }

}