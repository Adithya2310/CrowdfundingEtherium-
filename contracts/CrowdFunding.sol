// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CrowdFunding {
    
    // Campaign object
    struct Campaign{
        address owner;
        string title;
        string story;
        uint256 target;
        uint256 amountCollected;
        string image;
        uint256 deadline;
        address[] donators;
        uint256[] donation;
    }

    // to store the array of Campaigns
    mapping(uint256=>Campaign) public campaignList;
    uint256 public numberOfCampaigns=0;

    // to create a Campaign
    function createCampaign(
    address _owner,
    string memory  _title,
    string memory _story,
    uint256 _target,
    string memory _image,
    uint256 _deadline
    ) public returns (uint256)
    {
        Campaign storage campaign=campaignList[numberOfCampaigns];

        require(_deadline>=block.timestamp,"You need to enter a date in the future");

        campaign.owner=_owner;
        campaign.amountCollected=0;
        campaign.title=_title;
        campaign.story=_story;
        campaign.deadline=_deadline;
        campaign.target=_target;
        campaign.image=_image;

        return numberOfCampaigns++;
    } 

    // to donate to a campaign with the _id
    function donateToCampaign(uint _id) public payable {
        uint256 amount=msg.value;   
        Campaign storage campaign=campaignList[_id];
        campaign.donators.push(msg.sender);
        campaign.donation.push(amount);

        (bool sent,)=payable(campaign.owner).call{value:amount}("");

        if(sent)
        {
            campaign.amountCollected+=amount;
        }
    }

    // to get the list of donors for a particular campaign with _id
    function getDonators(uint _id) view public returns (address[] memory,uint256[] memory)
    {
        return (campaignList[_id].donators,campaignList[_id].donation);
    }

    // to get a list of all the campaigns that will exist
    function getCampaigns() view public returns (Campaign[] memory)
    {
        Campaign[] memory allCampaigns=new Campaign[](numberOfCampaigns);
        for(uint i = 0 ;i<numberOfCampaigns;++i){
            allCampaigns[i]=campaignList[i];
        }
        return allCampaigns;
    }

}