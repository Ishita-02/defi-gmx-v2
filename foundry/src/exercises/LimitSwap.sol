// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {console} from "forge-std/Test.sol";
import {IERC20} from "../interfaces/IERC20.sol";
import {IExchangeRouter} from "../interfaces/IExchangeRouter.sol";
import {IReader} from "../interfaces/IReader.sol";
import {Order} from "../types/Order.sol";
import {IBaseOrderUtils} from "../types/IBaseOrderUtils.sol";
import "../Constants.sol";

contract LimitSwap {
    IERC20 constant weth = IERC20(WETH);
    IERC20 constant usdc = IERC20(USDC);
    IExchangeRouter constant exchangeRouter = IExchangeRouter(EXCHANGE_ROUTER);

    receive() external payable {}

    // Task 1 - Receive execution fee refund from GMX

    // Task 2 - Create a limit order to swap USDC to WETH
    function createLimitOrder(uint256 usdcAmount, uint256 maxEthPrice)
        external
        payable
        returns (bytes32 key)
    {
        uint256 executionFee = 0.1 * 1e18;
        usdc.transferFrom(msg.sender, address(this), usdcAmount);

        // Task 2.1 - Send execution fee to the order vault
        exchangeRouter.sendWnt{value: executionFee}(ORDER_VAULT, executionFee);

        // Task 2.2 - Send USDC to the order vault

        usdc.approve(address(exchangeRouter), usdcAmount);
        exchangeRouter.sendTokens(address(usdc), ORDER_VAULT, usdcAmount);

        // Task 2.3 - Create an order to swap USDC to WETH

        uint256 minOutputAmount = usdcAmount * 1e20 / maxEthPrice;

        address[] memory pathToSwap = new address[](1);
        pathToSwap[0] = GM_TOKEN_ETH_WETH_USDC;

        exchangeRouter.createOrder(
            IBaseOrderUtils.CreateOrderParams({
                addresses: IBaseOrderUtils.CreateOrderParamsAddresses({
                    receiver: address(this),
                    cancellationReceiver: address(0),
                    callbackContract: address(0),
                    uiFeeReceiver: address(0),
                    market: address(0),
                    initialCollateralToken: address(usdc),
                    swapPath: pathToSwap
                }),
                numbers: IBaseOrderUtils.CreateOrderParamsNumbers({
                    sizeDeltaUsd: 0,
                    initialCollateralDeltaAmount: 0,
                    triggerPrice: 0,
                    acceptablePrice: 0,
                    executionFee: executionFee,
                    callbackGasLimit: 0,
                    minOutputAmount: minOutputAmount,
                    validFromTime: 0
                }),
                orderType: Order.OrderType.LimitSwap,
                decreasePositionSwapType: Order.DecreasePositionSwapType.NoSwap,
                isLong: false,
                shouldUnwrapNativeToken: false,
                autoCancel: false,
                referralCode:  bytes32(uint256(0))
            })
        );
    }
}
