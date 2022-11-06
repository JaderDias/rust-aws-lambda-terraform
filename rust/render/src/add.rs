use aws_sdk_dynamodb::model::AttributeValue;
use aws_sdk_dynamodb::{ Client, Error };

pub struct Item {
    pub domain_and_path: String,
    pub language_bcp47: String,
    pub is_edited: u8,
}

// Add an item to a table.
pub async fn add_item(client: &Client, item: &Item, table: &String) -> Result<(), Error> {
    let domain_and_path = AttributeValue::S(item.domain_and_path.to_string());
    let language_bcp47 = AttributeValue::S(item.language_bcp47.to_string());
    let is_edited = AttributeValue::N(item.is_edited.to_string());

    let request = client
        .put_item()
        .table_name(table)
        .item("DomainAndPath", domain_and_path)
        .item("LanguageBcp47", language_bcp47)
        .item("IsEdited", is_edited);

    println!("Executing request [{request:?}] to add item...");

    let resp = request.send().await?;

    let attributes = resp.attributes().unwrap();

    println!(
        "Added user {:?}, {:?} {:?}",
        attributes.get("DomainAndPath"),
        attributes.get("LanguageBcp47"),
        attributes.get("IsEdited")
    );

    Ok(())
}