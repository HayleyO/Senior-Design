
function Bluetooth() { }

export const connectBluetoothDevices = async () => {
    const device = await navigator.bluetooth.requestDevice({
        filters: [{ services: ['battery_service'] }]
    });
}