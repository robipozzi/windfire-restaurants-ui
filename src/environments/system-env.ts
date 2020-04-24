declare let ENV_VARS: {[key: string]: string};

const environmentVariables: {[key: string]: string} = {  
    RESTAURANT_SRV_BASEURL: ''
};

export const Environment = Object.assign(environmentVariables, ENV_VARS);