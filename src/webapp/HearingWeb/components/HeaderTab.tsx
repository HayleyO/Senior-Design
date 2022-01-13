var React = require('react');

export class HeaderTab extends React.Component {

    handleClick(event: React.MouseEvent<HTMLTableDataCellElement, MouseEvent>) {
        event.preventDefault();

    }

    render() {
        <td onClick={this.handleClick}>
            {this.props.children}
        </td>
    }
}