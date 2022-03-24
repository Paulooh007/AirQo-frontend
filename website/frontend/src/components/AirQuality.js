import React from 'react'
import Sensor from 'icons/homepage/sensor.svg';
import Checked from 'icons/homepage/checked.svg';
import UnChecked from 'icons/homepage/unchecked.svg';

const AirQuality = () => {
    return (
        <div>
            <div className="air-quality-section">
                <div className='air-quality-header'>
                    <h2>Air quality analytics for all</h2>
                    <p>Our low-cost air quality monitors help close the gap in air quality data in Africa<br /> thereby giving a unique and unprecedented look into air quality in the African<br /> Continent.</p>
                    <div className='air-quality-tabs'>
                        <div><span>For African cities</span></div>
                        <div><span>For Communities</span></div>
                    </div>
                </div>
                <div className='air-quality-content'>
                    <div className='content-container'>
                        <div className='selected'>
                            <div className="circle" />
                            <div className="text-wrapper">
                                <h4>Low cost air quality monitoring devices</h4>
                                <div>
                                    <Checked width={10} height={10} />
                                    <small>Designed for Africa's varying weather conditions</small>
                                </div>
                                <div>
                                    <Checked width={10} height={10} />
                                    <small>Easy installation and maintenance</small>
                                </div>
                            </div>
                        </div>
                        <div className='unselected'>
                            <div className="circle" />
                            <div className="text-wrapper">
                                <h4>Access to airquality analytics tools</h4>
                                <div>
                                    <UnChecked width={10} height={10} />
                                    <small>Easy to use analytics dashboard</small>
                                </div>
                                <div>
                                    <UnChecked width={10} height={10} />
                                    <small>Know your air through our mobile application</small>
                                </div>
                            </div>
                        </div>
                        <div className='unselected'>
                            <div className="circle" />
                            <div className="text-wrapper">
                                <h4>Robust API intergration</h4>
                                <div>
                                    <UnChecked width={10} height={10} />
                                    <small>Access air quality dat through the AirQo API</small>
                                </div>
                                <div>
                                    <UnChecked width={10} height={10} />
                                    <small>Intergrate the AirQo API with your applications</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className="image-container">
                        <Sensor width={464} height={376} />
                    </div>
                </div>
            </div>
        </div>
    )
}

export default AirQuality;