pragma solidity ^0.5.7;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";

contract GunToken is ERC721 {

    struct Gun {
        string gunName;
        uint256 serialNumber;
        string descriptions;
        string manufacturer;
    }

    Gun[] guns;

    mapping (uint256 => address) public gunIndexToOwner;

    mapping (address => uint256) public ownershipTokenCount;

    mapping (uint256 => address) public gunIndexToApproved;

    /// @dev Assigns ownership of a specific Gun to an address.
    function _transfer(address _from, address _to, uint256 _tokenId) internal {
        // Since the number of guns is capped to 2^32 we can't overflow this
        if(_from == address(0)) {
            ownershipTokenCount[_to] = 1;
        } else {
            ownershipTokenCount[_to]++;
        }
        // transfer ownership
        gunIndexToOwner[_tokenId] = _to;
        // When creating new guns _from is 0x0, but we can't account that address.
        if (_from != address(0)) {
            ownershipTokenCount[_from]--;
            // once the gun is transferred also clear sire allowances
            // delete sireAllowedToAddress[_tokenId];
            // clear any previously approved ownership exchange
            delete gunIndexToApproved[_tokenId];
        }
        // Emit the transfer event.
        // Transfer(_from, _to, _tokenId);
    }


    function _createToken(string memory _gunName, uint256 _serialNumber, string memory _descriptions, string memory _manufacturer, address _owner)
    public returns (uint) {

        Gun memory _gun = Gun({
            gunName: _gunName,
            serialNumber: _serialNumber,
            descriptions: _descriptions,
            manufacturer: _manufacturer
        });
        uint256 newGunId = guns.push(_gun) - 1;

        // It's probably never going to happen, 4 billion guns is A LOT, but
        // let's just be 100% sure we never let this happen.
        require(newGunId == uint256(uint32(newGunId)));


        // This will assign ownership, and also emit the Transfer event as
        // per ERC721 draft
        _transfer(address(0), _owner, newGunId);

        return newGunId;
    }

}
