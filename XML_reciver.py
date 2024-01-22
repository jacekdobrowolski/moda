import xml.etree.ElementTree as ET
from lxml import etree
import cx_Oracle
from io import StringIO

import output_file


class DB_connection:
    def __init__(
        self, hostname: str, port: int, sid: str, user: str, password: str
    ) -> None:
        dsn = cx_Oracle.makedsn(hostname, port, sid)  # or service_name='servicename'
        self.conn = cx_Oracle.connect(user=user, password=password, dsn=dsn)

    def query_database(self, query, params=None):
        cursor = self.conn.cursor()

        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)

        result = cursor.fetchone()

        cursor.close()

        return result[0].read()

    def close_connection(self):
        self.conn.close()

    @staticmethod
    def get_query_from_file(filename: str):
        with open(filename, "r") as file:
            query = file.read()

        return query

    @staticmethod
    def validate_xml_from_file(xml_path, xsd_path):
        # Load the schema
        with open(xsd_path, "rb") as schema_file:
            schema_root = etree.XML(schema_file.read())
        schema = etree.XMLSchema(schema_root)

        # Parse the XML file
        with open(xml_path, "r") as xml_file:
            xml_doc = etree.parse(xml_file)

        # Validate the XML file
        is_valid = schema.validate(xml_doc)

        if is_valid:
            print("Validation successful: XML is valid.")
        else:
            print("Validation failed: XML is invalid.")
            print(schema.error_log)

    @staticmethod
    def read_xml(file_path):
        tree = ET.parse(file_path)
        root = tree.getroot()

        ns = {"ns": "http://www.example.org"}

        for reservation in root.findall("ns:Reservation", ns):
            user = reservation.find("ns:User", ns)
            first_name = user.find("ns:FirstName", ns).text
            last_name = user.find("ns:LastName", ns).text

            print(f"User: {first_name} {last_name}")

            payment_amount = reservation.find("ns:PaymentAmount", ns).text
            print(f"Payment Amount: {payment_amount}")

    @staticmethod
    def validate_xml_from_query(xml_string, xsd_file_path):
        with open(xsd_file_path, "r") as xsd_file:
            xsd_tree = etree.parse(xsd_file)
        xsd_schema = etree.XMLSchema(xsd_tree)

        try:
            xml_doc = etree.parse(StringIO(xml_string))
            xsd_schema.assertValid(xml_doc)
            print(f"XML matches the schema from {xsd_file_path}")
        except etree.XMLSchemaError as e:
            print(f"XML doesnt match the schema from {xsd_file_path}")


if __name__ == "__main__":
    # use this function to locate oracle client libraries
    # cx_Oracle.init_oracle_client(lib_dir=r"C:\Programowanie\Narzedzia\Oracle\instantclient_21_12")

    db_conn = DB_connection(
        hostname="ora2.ia.pw.edu.pl",
        port=1521,
        sid="iais",
        user="MODA3",
        password="assword",
    )
    hotel_id = input("Podaj ID hotelu: ")
    start_date = input("Podaj date (rrrr-mm-dd) od której chcesz widziec rezerwacje: ")
    xsd_file_path = "UML/MODA3_XMLSchema.xsd"
    params = (start_date, hotel_id)

    query = db_conn.get_query_from_file("Eksport/EksportSelectWithParameters.sql")
    # query = db_conn.get_query_from_file("Eksport/EksportSelectFull.sql")

    out = db_conn.query_database(query, params)
    # print(out)

    db_conn.validate_xml_from_query(out, xsd_file_path)

    reservations = output_file.parseString(out, silence=True)
    for res in reservations.Reservation:
        print(res)
