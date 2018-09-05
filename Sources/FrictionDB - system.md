#  How FrictionDB stores data?

## Folder Structure
```js
|-- <Your Folder>
	|-- Objects
    	|-- 3B
        	|-- 9C358F36F0A31B6AD3E14F309C7CF198AC9246E8316F9CE543D5B19AC02B80
            | ...
        | ...
    |-- Entries
    	|-- data // table: data
        	|-- index.json
            |-- 100.json // 0...100
            |-- 200.json // 101...200
            | ...
        | ...
    |-- Logs
    	|-- 01-02-2018.log
        | ...
    |-- index.json
```
## Entries
### Types
Here are the authorized types:
- `String`
- `Int`
- `Float`
- `Date`
- `File`
- `JSON` (As NSDictionnary)
- `Password`
- `StringArray`
- `IntArray`
- `FloatArray`
- `DateArray`
- `PasswordArray`
- `JSONArray`
#### Example:
- `index.json`

```json
{
	id: "Int", // All FrictionDB records have an id
    name: "String",
    email: "String",
    password: "Password",
    picture: "File"
}
```
- `100.json`

```json
[{
	id: "0",
    name: "Arthur",
    email: "arguiot@gmail.com",
    password: "3B9C358F36F0A31B6AD3E14F309C7CF198AC9246E8316F9CE543D5B19AC02B80",
    picture: {
    	sha256: "3B9C358F36F0A31B6AD3E14F309C7CF198AC9246E8316F9CE543D5B19AC02B80",
        name: "Profile.jpg"
    }
},
{
	...
}]
```
