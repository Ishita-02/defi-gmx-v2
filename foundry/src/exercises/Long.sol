// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {console} from "forge-std/Test.sol";
import {IERC20} from "../interfaces/IERC20.sol";
import {IExchangeRouter} from "../interfaces/IExchangeRouter.sol";
import {IDataStore} from "../interfaces/IDataStore.sol";
import {IReader} from "../interfaces/IReader.sol";
import {Order} from "../types/Order.sol";
import {Position} from "../types/Position.sol";
import {Market} from "../types/Market.sol";
import {MarketUtils} from "../types/MarketUtils.sol";
import {Price} from "../types/Price.sol";
import {IBaseOrderUtils} from "../types/IBaseOrderUtils.sol";
import {Oracle} from "../lib/Oracle.sol";
import "../Constants.sol";

contract Long {
    IERC20 constant weth = IERC20(WETH);
    IERC20 constant usdc = IERC20(USDC);
    IExchangeRouter constant exchangeRouter = IExchangeRouter(EXCHANGE_ROUTER);
    IDataStore constant dataStore = IDataStore(DATA_STORE);
    IReader constant reader = IReader(READER);
    Oracle immutable oracle;
    // Position immutable position;

    constructor(address _oracle) {
        oracle = Oracle(_oracle);
    }

    receive() external payable{}

    // Task 1 - Receive execution fee refund from GMX

    // Task 2 - Create an order to long ETH with WETH collateral
    function createLongOrder(uint256 leverage, uint256 wethAmount)
        external
        payable
        returns (bytes32 key)
    {
        // uint256 executionFee = 0.1 * 1e18;
        // weth.transferFrom(msg.sender, address(this), wethAmount);

        // // Task 2.1 - Send execution fee to the order vault
        // exchangeRouter.sendWnt{value: executionFee}(ORDER_VAULT, executionFee);

        // // Task 2.2 - Send WETH to the order vault
        // usdc.approve(address(exchangeRouter), wethAmount);
        // exchangeRouter.sendTokens(address(weth), ORDER_VAULT, wethAmount);

        // // Task 2.3 - Create an order

        // uint256 minOutputAmount = usdcAmount * 1e20 / maxEthPrice;
        // uint256 currentPrice = oracle.getPrice(CHAINLINK_ETH_USD);

        // uint256 sizeDeltaUsd = (currentPrice / 1e8) * 1e30;
        // uint256 acceptablePrice = (currentPrice / 1e8) * 1.01 * 1e12;

        // address[] memory pathToSwap = new address[](1);
        // pathToSwap[0] = GM_TOKEN_ETH_WETH_USDC;

        // exchangeRouter.createOrder(
        //     IBaseOrderUtils.CreateOrderParams({
        //         addresses: IBaseOrderUtils.CreateOrderParamsAddresses({
        //             receiver: address(this),
        //             cancellationReceiver: address(0),
        //             callbackContract: address(0),
        //             uiFeeReceiver: address(0),
        //             market: GM_TOKEN_ETH_WETH_USDC,
        //             initialCollateralToken: address(usdc),
        //             swapPath: pathToSwap
        //         }),
        //         numbers: IBaseOrderUtils.CreateOrderParamsNumbers({
        //             sizeDeltaUsd: sizeDeltaUsd,
        //             initialCollateralDeltaAmount: 0,
        //             triggerPrice: 0,
        //             acceptablePrice: acceptablePrice,
        //             executionFee: executionFee,
        //             callbackGasLimit: 0,
        //             minOutputAmount: minOutputAmount,
        //             validFromTime: 0
        //         }),
        //         orderType: Order.OrderType.MarketIncrease,
        //         decreasePositionSwapType: Order.DecreasePositionSwapType.NoSwap,
        //         isLong: true,
        //         shouldUnwrapNativeToken: false,
        //         autoCancel: false,
        //         referralCode:  bytes32(uint256(0))
        //     })
        // );
    }

    // Task 3 - Get position key
    function getPositionKey() public view returns (bytes32 key) {
        // position.getPositionKey(msg.sender, market, collateralToken, isLong);
    }

    // Task 4 - Get position
    function getPosition(bytes32 key)
        public
        view
        returns (Position.Props memory)
    {
        // return reader.getPosition(dataStore, key);
    }

    // Task 5 - Get position profit and loss
    function getPositionPnlUsd(bytes32 key, uint256 ethPrice)
        external
        view
        returns (int256)
    {
    //     MarketUtils.MarketPrices
    //     reader.getPositionPnlUsd(dataStore, market, prices, key, sizeDeltaUsd);
    }

    // Task 6 - Create an order to close the long position created by this contract
    function createCloseOrder() external payable returns (bytes32 key) {
        uint256 executionFee = 0.1 * 1e18;

        // Task 6.1 - Get position

        // Task 6.2 - Send execution fee to the order vault

        // Task 6.3 - Create an order
    }
}
