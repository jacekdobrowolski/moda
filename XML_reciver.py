import xml.etree.ElementTree as ET
from lxml import etree
import cx_Oracle
from io import StringIO


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
        # Parse the XML file
        tree = ET.parse(file_path)
        root = tree.getroot()

        # Define the namespace
        ns = {"ns": "http://www.example.org"}

        # Iterate through each reservation
        for reservation in root.findall("ns:Reservation", ns):
            # Find user details
            user = reservation.find("ns:User", ns)
            first_name = user.find("ns:FirstName", ns).text
            last_name = user.find("ns:LastName", ns).text

            # Print user details
            print(f"User: {first_name} {last_name}")

            # Find and print other details of reservation
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
            return True
        except etree.XMLSchemaError as e:
            return str(e)


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

    params = ("2024-01-02", 1)
    # query = get_query_from_file("Eksport/EksportSelectWithParameters.sql")
    query = db_conn.get_query_from_file("Eksport/EksportSelectFull.sql")

    out = db_conn.query_database(query)
    print(out)
    db_conn.validate_xml_from_query(out, "UML/MODA3_XMLSchema.xsd")
