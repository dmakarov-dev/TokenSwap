// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUniswapV2Router02 {
    function swapExactTokensForETH(
        uint amountIn, 
        uint amountOutMin, 
        address[] calldata path, 
        address to, 
        uint deadline
    ) external returns (uint[] memory amounts);
}

contract TokenSwap {
    address public tokenAddress;
    address public uniswapRouterAddress;

    constructor(address _tokenAddress, address _uniswapRouterAddress) {
        tokenAddress = _tokenAddress;
        uniswapRouterAddress = _uniswapRouterAddress;
    }

    function swapTokensForEth(uint amountIn, uint amountOutMin) external {
        address[] memory path = new address[](2);
        path[0] = tokenAddress;
        path[1] = IUniswapV2Router02(uniswapRouterAddress).WETH();

        uint deadline = block.timestamp + 120; // 2 minute deadline
        IERC20(tokenAddress).approve(uniswapRouterAddress, amountIn);
        IUniswapV2Router02(uniswapRouterAddress).swapExactTokensForETH(
            amountIn,
            amountOutMin,
            path,
            msg.sender,
            deadline
        );
    }
}
