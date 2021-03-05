// for representing chained operations using redux-thunk
import {
  LOAD_DEVICES_STATUS_SUCCESS,
  LOAD_DEVICES_STATUS_FAILURE,
  LOAD_NETWORK_UPTIME_SUCCESS,
  LOAD_NETWORK_UPTIME_FAILURE,
  LOAD_ALL_DEVICES_UPTIME_SUCCESS,
  LOAD_ALL_DEVICES_UPTIME_FAILURE,
} from "./actions";
import {
  getDevicesStatusApi,
  getNetworkUptimeApi,
  getAllDevicesUptimeApi,
} from "views/apis/deviceMonitoring";

export const loadDevicesStatusData = () => async (dispatch) => {
  return await getDevicesStatusApi()
    .then((responseData) => {
      let data;
      try {
        data = responseData.data.data[0];
      } catch (err) {
        data = JSON.parse(responseData.data.replace(/\bNaN\b/g, "null"))
          .data[0];
      }

      dispatch({
        type: LOAD_DEVICES_STATUS_SUCCESS,
        payload: data,
      });
    })
    .catch((err) => {
      dispatch({
        type: LOAD_DEVICES_STATUS_FAILURE,
        payload: err,
      });
    });
};

export const loadNetworkUptimeData = (days) => async (dispatch) => {
  return await getNetworkUptimeApi({ days })
    .then((responseData) => {
      dispatch({
        type: LOAD_NETWORK_UPTIME_SUCCESS,
        payload: responseData.data,
      });
    })
    .catch((err) => {
      dispatch({
        type: LOAD_NETWORK_UPTIME_FAILURE,
        payload: err,
      });
    });
};

export const loadAllDevicesUptimeData = (days) => async (dispatch) => {
  return await getAllDevicesUptimeApi({ days })
    .then((responseData) => {
      dispatch({
        type: LOAD_ALL_DEVICES_UPTIME_SUCCESS,
        payload: responseData.data,
      });
    })
    .catch((err) => {
      dispatch({
        type: LOAD_ALL_DEVICES_UPTIME_FAILURE,
        payload: err,
      });
    });
};