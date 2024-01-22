import xml.etree.ElementTree as ET
from lxml import etree


def validate_xml(xml_path, xsd_path):
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

        # Add more fields as per your requirement


# Replace 'your_file.xml' with the path to your XML file
validate_xml("UML/MODA3_XML.xml", "UML/MODA3_XMLSchema.xsd")
read_xml("UML/MODA3_XML.xml")
