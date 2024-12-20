// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Define the "TrafficArrowGame" contract
contract TrafficArrowGame {
    // Mapping to track arrow points for each player
    mapping(address => uint256) private arrowPoints;

    // Total arrow points in the game
    uint256 public totalArrowPoints;

    // Events
    event ArrowPointsIncreased(address indexed player, uint256 currentPoints);
    event ArrowPointsReset(address indexed player);
    event TotalPointsUpdated(uint256 newTotalPoints);

    // Modifier to ensure valid address
    modifier validAddress(address player) {
        require(player != address(0), "Invalid player address");
        _;
    }

    // Function to retrieve a player's arrow points
    function getArrowPoints(address player) external view returns (uint256) {
        return arrowPoints[player];
    }

    // Function to increase arrow points for a player
    function increaseArrowPoints(
        address player,
        uint256 points
    ) external validAddress(player) {
        require(points > 0, "Points must be greater than zero");

        arrowPoints[player] += points;
        totalArrowPoints += points;

        emit ArrowPointsIncreased(player, arrowPoints[player]);
        emit TotalPointsUpdated(totalArrowPoints);
    }

    // Function to reset a player's arrow points to zero
    function resetArrowPoints(address player) external validAddress(player) {
        totalArrowPoints -= arrowPoints[player];
        arrowPoints[player] = 0;

        emit ArrowPointsReset(player);
        emit TotalPointsUpdated(totalArrowPoints);
    }
}
