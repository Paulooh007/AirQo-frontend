import { combineReducers } from 'redux';
import airqloudsReducer from './AirQlouds/reducers';
import newsletterReducer from './Newsletter/reducers';
import getInvolvedReducer from './GetInvolved/reducers';
import exploreDataReducer from './ExploreData/reducers';

export default combineReducers({
  airqlouds: airqloudsReducer,
  newsletter: newsletterReducer,
  getInvolved: getInvolvedReducer,
  exploreData: exploreDataReducer
});
