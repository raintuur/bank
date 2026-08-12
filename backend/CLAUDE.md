# CLAUDE.md

See fail annab juhiseid Claude Code'ile (claude.ai/code) selles repositooriumis töötamiseks.

**Keel:** Kõik uued kanded sellesse faili kirjutatakse eesti keeles.

## Käsud

```bash
# Ehitamine
./gradlew build

# Käivitamine (nõuab lokaalset PostgreSQL-i)
./gradlew bootRun

# Testide käivitamine
./gradlew test

# Ühe testiklassi käivitamine
./gradlew test --tests "ee.bcs.bank.BankApplicationTests"

# Ainult kompileerimine (käivitab ka MapStructi annotatsiooni töötluse)
./gradlew compileJava
```

## Andmebaasi seadistamine

PostgreSQL peab töötama `localhost`-is järgmiste seadetega:
- Andmebaas: `vali_it`
- Kasutajanimi: `postgres`
- Parool: `student123`
- Mugav DB url: `jdbc:postgresql://localhost:5432/vali_it`

Käivita skriptid järjekorras kaustast `docs/database`:
1. `1_reset_database.sql` — kustutab ja loob uuesti `bank` skeema
2. `2_create.sql` — loob kõik tabelid
3. `3_import.sql` — lisab algandmed

Kõik tabelid asuvad `bank` skeemas.

## Arhitektuur

Tegemist on Spring Boot 4.x / Java 21 REST backendiga pangaautomaatide asukoharakenduse jaoks. Frontend on eraldi Vue 3 SPA (ei ole selles repos).

### Kihtide struktuur

```
controller/       REST endpointid + päringu/vastuse DTOd
service/          Äriloogika
persistence/      JPA entiteedid, repositooriumid, MapStructi mapperid
infrastructure/   Läbivad komponendid: erindi tüübid, veakoodid, globaalne erindite käsitleja
```

Igal domeenialasel (location, city, transactiontype, login) on oma alampakk `controller/`-is koos DTOdega, teenusklass ja persistence pakk.

### Soovituslik failide ja kaustade struktuur

See on backendi soovituslik sihtstruktuur. Loo ainult funktsionaalsuse jaoks vajalikud
paketid ja failid; `example` tähistab päris domeeni nime, näiteks `location` või `city`.

```text
backend/
├── gradle/
│   └── wrapper/                                  // Gradle Wrapperi failid
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── ee/bcs/bank/                      // Rakenduse baaspakett
│   │   │       ├── controller/                    // REST endpointid ja DTOd
│   │   │       │   └── example/                   // Domeeni alampakett, nt location
│   │   │       │       ├── ExampleController.java // REST-kontroller
│   │   │       │       └── dto/                   // Päringu ja vastuse DTOd
│   │   │       │           └── ExampleInfo.java
│   │   │       ├── infrastructure/                // Läbivad tehnilised komponendid
│   │   │       │   ├── RestExceptionHandler.java // Globaalne API veakäsitleja
│   │   │       │   ├── error/                     // Standardne veavastuse mudel
│   │   │       │   │   └── ApiError.java
│   │   │       │   └── exception/                 // Kohandatud erindiklassid
│   │   │       │       ├── DataNotFoundException.java
│   │   │       │       ├── ForbiddenException.java
│   │   │       │       └── PrimaryKeyNotFoundException.java
│   │   │       ├── persistence/                   // Andmebaasikiht
│   │   │       │   └── example/                   // Domeeni alampakett, nt location
│   │   │       │       ├── Example.java           // JPA entiteet
│   │   │       │       ├── ExampleMapper.java     // MapStructi mapper
│   │   │       │       └── ExampleRepository.java // Spring Data repositoorium
│   │   │       ├── service/                       // Äriloogika teenused
│   │   │       │   └── ExampleService.java
│   │   │       └── BankApplication.java           // Rakenduse käivitusklass
│   │   └── resources/
│   │       ├── application.properties             // Rakenduse ja DB seadistus
│   │       └── spy.properties                     // P6Spy SQL-logimise seadistus
│   └── test/
│       └── java/
│           └── ee/bcs/bank/                       // Ühiku- ja integratsioonitestid
├── .gitattributes
├── .gitignore
├── build.gradle                                   // Sõltuvused ja build'i seadistus
├── gradlew                                        // Gradle Wrapper Linuxile ja macOS-ile
├── gradlew.bat                                    // Gradle Wrapper Windowsile
└── settings.gradle                                // Gradle projekti nimi ja moodulid
```

Andmebaasi loomise ja algandmete SQL-skriptid asuvad backendist väljaspool kaustas
`docs/database/`. Pikem struktuurikirjeldus: [`docs/structure/backend-structure.md`](../docs/structure/backend-structure.md).

### Olulised konventsioonid

**DTOd vs entiteedid** — Kontrollerid näevad ainult DTOsid. MapStructi mapperid (liidesed annotatsiooniga `@Mapper`) teisendavad DTOd JPA entiteetideks ja vastupidi. Genereeritud mapperi implementatsioonid tekivad kausta `src/main/generated/`.

**Veakäsitlus** — Teenustest visatakse kohandatud erindeid (`DataNotFoundException`, `ForbiddenException`, `PrimaryKeyNotFoundException`), mille püüab kinni `RestExceptionHandler` (`@ControllerAdvice`). Kõik äriveateated ja numbrilised veakoodid on koondatud `ErrorResponse` enumi.

**Muutujate nimetamine** — Muutuja nimi peab peegeldama täistüüpi: `LocationDetailDto locationDetailDto`, mitte `LocationDetailDto dto`.

**Meetodi nimetamine** — `getX()` lubab kindlat tagastust. Kui meetod sisaldab tingimislikku loogikat ja muteerib DTO-d, kasuta `handle`-prefiksit ja anna DTO parameeter sisse: `handleAddImageData(LocationDetailDto locationDetailDto, Integer locationId)`.

**Entiteedi otsing ID järgi** — `repository.findById()` kasutamine `orElseThrow`-ga peab olema `public getValid<Entiteet>By(Integer <entiteet>Id)` meetodis vastava service klassi all (nt `getValidLocationBy(Integer locationId)` `LocationService`-s, `getValidCityBy(Integer cityId)` `CityService`-s).

**SQL päringud** — Kohandatud päringud on JPQL, kirjutatud otse Spring Data repositooriumi liidesele `@Query` annotatsiooniga. `LocationTransactionTypeRepository` kasutab konstruktori avaldist otse DTOsse projekteerimiseks.

**SQL logimine** — P6Spy on seadistatud (`spy.properties`), nii et täielik parameetritega SQL kuvatakse konsoolis. Selle saab keelata, lülitades `application.properties`-is tagasi kommenteeritud tavaliste PostgreSQL seadetele.

# Backend Coding Conventions

## Development Principles

### Service Method Decomposition

**Extract validation and sub-steps into private methods.**

When a service method contains distinct logical steps (validate, build, persist, notify), extract each into a named private method:

```java
// The public method should read like a high-level summary of the flow — each step is a named private method:
public UserDto createUser(UserCreateRequest request) {
    validateEmailUniqueness(request.email());
    AppUser user = buildUser(request);
    userRepository.save(user);
    sendActivationEmail(user);
    return userMapper.toUserDto(user);
}

private void validateEmailUniqueness(String email) {
    if (userRepository.findUserBy(email).isPresent()) {
        throw new ConflictException(ErrorCode.EMAIL_ALREADY_EXISTS);
    }
}

// ❌ Validation inlined — intent is buried in implementation detail
public UserDto createUser(UserCreateRequest request) {
    if (userRepository.findUserBy(request.email()).isPresent()) {
        throw new ConflictException(ErrorCode.EMAIL_ALREADY_EXISTS);
    }
    ...
}
```

**Rule:** If you need a comment to explain what a block does, it should be a method instead.


### 6. Service Method Naming — `findValid` Prefix

**Use `findValid` prefix for public service methods that fetch an entity and throw if not found.**

This makes it clear at the call site that validation is happening — not just a lookup.

```java
// ✅ findValid — signals that an exception is thrown if not found
public Institution findValidInstitution(Long institutionId) {
    return institutionRepository.findById(institutionId)
            .orElseThrow(() -> new IdNotFoundException(ErrorCode.INSTITUTION_NOT_FOUND, institutionId));
}

// Call site clearly communicates: this will throw if institution doesn't exist
Institution institution = institutionService.findValidInstitution(institutionId);

// ❌ find — implies Optional or null return, hides the validation
public Institution findInstitution(Long institutionId) { ... }
```

**`findValid` methods must live in the service class named after the entity** — not in a consuming service:

```java
// ✅ ChildService owns findValidChild — callers depend on ChildService
@Service
public class ChildService {
    public Child findValidChild(Long childId) { ... }
}

// Call site in another service
Child child = childService.findValidChild(childId);

// ❌ findValidChild defined in ParentService — wrong owner
@Service
public class ParentService {
    public Child findValidChild(Long childId) { ... }
}
```

### Method Ordering in Classes

**Public methods come before private methods.**

```java
// ✅ Public first, private after
public LoginResponse login(LoginRequest request) { ... }
public void activateAccount(ActivateAccountRequest request) { ... }

private AppUser findAndAuthenticateUser(String email, String password) { ... }
private void validatePassword(String rawPassword, String passwordHash) { ... }
private void validateUserIsActive(AppUser user) { ... }

// ❌ Private methods mixed in between public methods
public LoginResponse login(LoginRequest request) { ... }
private AppUser findAndAuthenticateUser(String email, String password) { ... }
public void activateAccount(ActivateAccountRequest request) { ... }
```

This applies to all classes: controllers, services, mappers, etc.

**Within public methods, use CRUD order: POST → GET (single) → GET (list) → PUT/PATCH → DELETE**

> ⚠️ **Every time you add a new method to a Controller or Service class**, determine its CRUD position first and insert it at the correct location — do not append it at the top or bottom by default.

```java
// ✅ CRUD järjestus
public void createUser(...)          { ... }  // POST
public UserDto getUser(...)          { ... }  // GET - single
public List<UserDto> getUsers(...)   { ... }  // GET - list
public UserDto updateUser(...)       { ... }  // PUT/PATCH
public void deleteUser(...)          { ... }  // DELETE
```

Applies to controllers and their corresponding service classes.

**Within private methods, follow execution flow (call hierarchy)** — each method appears just before the methods it calls. This way the file reads top-to-bottom like a story:

```java
// ✅ Caller before callee
private void createAndLinkParent(...) {
    assignActivationToken(parent);
    linkParentToChild(parent, child);
    sendActivationEmail(parent);
}

private void assignActivationToken(...) { ... }

private void linkParentToChild(...) {
    parentChildRepository.save(createParentChild(parent, child));
}

private ParentChild createParentChild(...) { ... }
private ParentChildId createParentChildId(...) { ... }

private void sendActivationEmail(...) { ... }
```

### Object Creation — `create` Helper Methods

**Never inline multi-line object construction in a method body.** Extract object creation into a private `create` method so the calling method stays readable as a flow description:

```java
// ✅ Calling method reads as logic flow
private void linkParentToChild(AppUser parent, Child child) {
    parentChildRepository.save(createParentChild(parent, child));
}

private ParentChild createParentChild(AppUser parent, Child child) {
    ParentChild parentChild = new ParentChild();
    parentChild.setId(createParentChildId(parent.getId(), child.getId()));
    parentChild.setParent(parent);
    parentChild.setChild(child);
    return parentChild;
}

// ❌ Object construction inlined — intent buried in boilerplate
private void linkParentToChild(AppUser parent, Child child) {
    ParentChildId id = new ParentChildId();
    id.setParentId(parent.getId());
    id.setChildId(child.getId());
    ParentChild parentChild = new ParentChild();
    parentChild.setId(id);
    ...
}
```

**Note:** This applies when multiple entities or non-DTO inputs are involved. For DTO → Entity conversion, always use a MapStruct mapper instead.

### Inline vs. Variable for Intermediate Results

**Do not pass a method call result directly as an argument to another method.** Assign it to a named variable first — this makes each step readable and debuggable:

```java
// ✅ Named variable — each step is clear
List<ClassGroupSummary> summaries = classGroupSummaryRepository.findClassGroupSummariesBy(sort);
return classGroupSummaryMapper.toClassGroupDtos(summaries);

// ❌ Inline — reader must parse inside-out
return classGroupSummaryMapper.toClassGroupDtos(
        classGroupSummaryRepository.findClassGroupSummariesBy(sort));
```

---

### JPA `save()` Return Value

**Do not assign the return value of `repository.save(entity)` to a new variable.** Hibernate updates the original entity in-place — the returned object is the same reference, so a separate `saved` variable is redundant:

```java
// ✅ Use the original entity after save
userRepository.save(user);
emailService.sendActivationEmail(user.getEmail(), activationLink);
return userMapper.toUserDto(user);

// ❌ Redundant — saved and user are the same object
AppUser saved = userRepository.save(user);
emailService.sendActivationEmail(saved.getEmail(), activationLink);
return userMapper.toUserDto(saved);
```

---

## Coding Conventions

### Spring REST Controller & OpenAPI Annotations

**Philosophy: "Just enough" documentation**

Document only what cannot be inferred from code. Avoid verbose annotations that duplicate information already visible in types, validation constraints, or method signatures.

---

#### `@RequestMapping` — Class-Level Base Path Only

**`@RequestMapping` on the controller class must contain only the static base path — never a path variable.**

Path variables belong on the individual method mappings (`@GetMapping`, `@PostMapping`, etc.), not on the class.

```java
// ✅ Base path only on class, path variable on method
@RequestMapping("/api/children")
public class ParentController {

    @GetMapping("/{childId}/parents")
    public List<UserDto> getChildParents(@PathVariable Long childId, ...) { ... }

    @PostMapping("/{childId}/parents")
    public void addParentToChild(@PathVariable Long childId, ...) { ... }
}

// ❌ Path variable in class-level @RequestMapping
@RequestMapping("/api/children/{childId}/parents")
public class ParentController {

    @GetMapping
    public List<UserDto> getChildParents(@PathVariable Long childId, ...) { ... }
}
```

---

#### Required Annotations on Every Endpoint

Every controller class and every endpoint method **must** have OpenAPI annotations:

**Controller class:**
- `@Tag(name = "...", description = "...")` — groups endpoints in Swagger UI; name matches the tag in `openAPI.json`

**Every endpoint method:**
- `@Operation(summary = "...", description = "...")` — summary is short (matches `openAPI.json`); description explains business rules
- `@SecurityRequirements` — on public endpoints (no auth required); omit on secured endpoints (global `bearerAuth` applies)
- `@ApiResponses({...})` — document all possible response codes

**Example:**
```java
@Tag(name = "Auth", description = "Autentimine ja konto aktiveerimine")
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Operation(summary = "Aktiveeri konto", description = "Kasutaja seab parooli aktiveerimislingi tokeniga.")
    @SecurityRequirements
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Konto edukalt aktiveeritud",
                    content = @Content(schema = @Schema(implementation = ResponseMessage.class))),
            @ApiResponse(responseCode = "400", description = "Vigased andmed / kehtetu token / aegunud token",
                    content = @Content(schema = @Schema(implementation = ErrorResponse.class)))
    })
    @PostMapping("/activate")
    public ResponseMessage activateAccount(@RequestBody @Valid ActivateAccountRequest request) { ... }
}
```

**Source of truth:** When implementing a controller, read the corresponding endpoint spec from `docs/info/07-api-design/openAPI.json` — use the `summary`, `description`, `tags`, and response codes from there.

**Error response descriptions:** For `@ApiResponse` error descriptions, look up the relevant `ErrorCode` enum values in `ee.bcs.classmoney.infrastructure.error.ErrorCode` and compose the description from their `message` fields. Example: if an endpoint can throw `TOKEN_INVALID` ("Token on vigane või rikutud") and `TOKEN_EXPIRED` ("Token on aegunud"), the description should reflect both messages.

---

#### Endpoint Annotation Order

Place annotations on endpoint methods in this order:

```java
@Operation(...)
@ApiResponses({...})
@PostMapping / @GetMapping / @PutMapping / @PatchMapping / @DeleteMapping
@PreAuthorize(...)
@ResponseStatus(...)   // only when needed
public void createItem(...) { ... }
```

---

#### Return Type Simplicity

**Only use `ResponseEntity<T>` when you need to:**
- Return a body with a non-200 status (e.g. 201 Created with body)
- Add custom headers
- Return different status codes based on business logic

**For endpoints that always return 200 OK:**
- Return the DTO directly: `public UserDto getUser()`
- Avoid unnecessary wrapping: `ResponseEntity.ok(dto)` when `return dto;` is sufficient

**For endpoints that return a non-200 status with no body (e.g. 204 No Content):**
- Use `@ResponseStatus` + `void` instead of `ResponseEntity<Void>`

**Examples:**
```java
// ✅ Simple endpoint - always 200 OK
public HealthResponse health() {
    return new HealthResponse("UP", System.currentTimeMillis());
}

// ✅ No-body endpoint - use @ResponseStatus + void
@ResponseStatus(HttpStatus.NO_CONTENT)
public void deleteItem(@PathVariable Long id) {
    itemService.delete(id);
}

// ✅ Body + non-200 status - use ResponseEntity
public ResponseEntity<UserDto> createUser(@RequestBody @Valid CreateUserRequest request) {
    UserDto created = userService.create(request);
    return ResponseEntity.status(HttpStatus.CREATED).body(created);
}

// ❌ Unnecessary - ResponseEntity<Void> when @ResponseStatus + void is simpler
public ResponseEntity<Void> deleteItem(@PathVariable Long id) {
    itemService.delete(id);
    return ResponseEntity.noContent().build();
}
```

---

#### OpenAPI Annotation Minimalism

**Springdoc-openapi auto-detects:**
- Return types from method signatures
- Media types (application/json is default)
- Schemas from DTO classes
- Validation constraints from Bean Validation annotations

**Only use explicit `@Content` and `@Schema` when:**
- Method returns generic types (`Object`, `ResponseEntity<?>`)
- Different response types for different status codes
- Multiple media types (JSON + XML)
- Documentation of business logic that isn't visible in code

**For simple endpoints:**
```java
// ✅ Minimal - Springdoc generates schema automatically
@GetMapping
@Operation(summary = "Kontrolli serveri tervist")
@ApiResponse(responseCode = "200", description = "Server töötab korrektselt")
public HealthResponse health() {
    return new HealthResponse("UP", System.currentTimeMillis());
}

// ❌ Over-documented - redundant @Content
@ApiResponse(
    responseCode = "200",
    description = "Server töötab korrektselt",
    content = @Content(
        mediaType = "application/json",  // ← Already known
        schema = @Schema(implementation = HealthResponse.class)  // ← Already known
    )
)
```

**For complex endpoints:**
```java
// ✅ Explicit @Content needed for different response types
@PostMapping("/users")
@ApiResponses({
    @ApiResponse(
        responseCode = "201",
        description = "Kasutaja loodud",
        content = @Content(schema = @Schema(implementation = UserDto.class))
    ),
    @ApiResponse(
        responseCode = "400",
        description = "Vigased andmed",
        content = @Content(schema = @Schema(implementation = ErrorResponse.class))
    )
})
public ResponseEntity<UserDto> createUser(@RequestBody @Valid CreateUserRequest request) {
    UserDto created = userService.create(request);
    return ResponseEntity.status(HttpStatus.CREATED).body(created);
}
```

---

#### DTO Field Documentation Levels

**Level 1: IDs and technical fields**
```java
// Minimal or none
@NotNull
private Long id;

private LocalDateTime createdAt;
```

**Level 2: Standard data fields**
```java
// Example only
@Schema(example = "Mari")
@NotBlank @Size(max = 50)
private String firstName;
```

**Level 3: Business logic fields**
```java
// Description + example
@Schema(
    description = "Kulu summa eurosentides (nt 1050 = 10.50€)",
    example = "1050"
)
@NotNull @Min(1)
private Integer amountCents;
```

**Level 4: Complex business rules**
```java
// Detailed description + example
@Schema(
    description = "Kulutuse jaotus õpilaste vahel. Kui tühi, arvutatakse " +
                  "automaatselt võrdne jaotus. Kui täidetud, peavad summad " +
                  "kokku andma täpse kulu summa.",
    example = "[{\"studentId\": 1, \"amount\": 500}, {\"studentId\": 2, \"amount\": 550}]"
)
private List<ExpenseAllocation> customAllocations;
```

---

#### Bean Validation + Swagger Integration

**Springdoc automatically translates Bean Validation annotations to OpenAPI constraints:**

| Bean Validation | OpenAPI (automatic) |
|-----------------|---------------------|
| `@NotNull` | `required: true` |
| `@Size(min=3, max=50)` | `minLength: 3, maxLength: 50` |
| `@Min(0)` / `@Max(100)` | `minimum: 0, maximum: 100` |
| `@Email` | `format: email` |
| `@Pattern(regexp="...")` | `pattern: "..."` |

**DO NOT duplicate validation constraints in @Schema:**
```java
// ✅ Validation is sufficient - Swagger generates constraints
@Schema(example = "Mari")
@NotBlank
@Size(min = 1, max = 50)
private String firstName;

// ❌ Redundant - duplicates @Size constraints
@Schema(
    example = "Mari",
    required = true,      // ← @NotBlank already says this
    minLength = 1,        // ← @Size already says this
    maxLength = 50        // ← @Size already says this
)
@NotBlank
@Size(min = 1, max = 50)
private String firstName;
```

---

#### Class-Level Documentation

**Use class-level `@Schema` for overview:**
```java
@Schema(description = "Uue klassi loomise päring")
public record CreateClassGroupRequest(

    @Schema(example = "1a")
    @NotBlank @Size(max = 20)
    String name,

    @Schema(
        description = "Kooli/lasteaia ID, kuhu klass kuulub",
        example = "5"
    )
    @NotNull
    Long institutionId,

    @Schema(
        description = "Klassijuhataja kasutaja ID (optional)",
        example = "10"
    )
    Long teacherUserId
) {}
```

---

#### Documentation Rules Summary

**DO:**
- ✅ Document `example` values (most useful for API testing)
- ✅ Explain business logic not visible in code
- ✅ Document formats (personal code, phone number, amount in cents)
- ✅ Use class-level `@Schema` for general context
- ✅ Let Springdoc auto-translate validation constraints

**DON'T:**
- ❌ Don't repeat what Bean Validation already says
- ❌ Don't write "User name" when field is `userName`
- ❌ Don't document technical fields (id, createdAt, updatedAt)
- ❌ Don't add `required`, `minLength`, `maxLength` when validation exists
- ❌ Don't use `@Content` when return type is clear

**Warning signs of over-documentation:**
- DTO class exceeds 150 lines due to annotations
- Annotations repeat information from field names or types
- Every small change requires updating 10 lines of annotations

---

### Business Layer Method Naming — Avoid `byX` Input Patterns

**In controllers and services, do not mirror input parameter names in method names.**

Method names in the business layer should describe *what the method returns or does*, not *how it is filtered*. The parameters already carry that information.

```java
// ✅ Business-logic name — describes what is returned
public List<UserDto> getChildParents(Long childId, ...) { ... }

// ❌ Mirrors the input — redundant, makes names unnecessarily long
public List<UserDto> getParentsByChild(Long childId, ...) { ... }
```

**Why:** `byX` patterns duplicate information already visible in the parameter list and make names grow unwieldy when multiple parameters are involved (`getItemsByUserAndStatusAndDate(...)`). Business names stay short and read as domain concepts.

**Repository layer:** The `findEntityBy` convention is intentional there because Spring Data naming drives query generation. Even so, prefer the short form (`findEntityBy`) over appending field names unless a signature conflict forces it.

---

### Spring Data JPA Repository Method Naming

**Custom repository query methods must follow this naming pattern:**

**Preferred format (when no signature conflicts):**
```java
// Single result
findEntityBy(Type parameterName);

// Multiple results
findEntitiesBy(Type parameterName);
```

**When signature conflicts occur (same parameter type), keep the first method short and add field names for the rest:**
```java
// 1st method with String param keeps short version
findEntityBy(Type parameterName);

// Additional String methods append the field name
findEntityBy{Field}(Type parameterName);
```

**Rules:**
- Use entity name in **singular** form for single results: `findUserBy`, `findChildBy`, `findInstitutionBy`
- Use entity name in **plural** form for list results: `findUsersBy`, `findChildrenBy`, `findInstitutionsBy`
- **Junction table erijuht**: Junction table entity'de puhul (nt `ParentChild`) kasuta lihtsustatud plurali, kui grammatiliselt korrektne plural on keeruline:
    - `findParentChildsBy()` ✓ (mitte `findParentChildrenBy()`)
    - `findTreasurerClassGroupsBy()` ✓
- For each entity + parameter type pair, only the first method keeps the short form; additional methods append the relevant field name
- Parameter name in signature should be descriptive: `email`, `activationToken`, `institutionId`, etc.
- This convention requires `@Query` annotations since field names are not in the method name

**Examples:**
```java
// Preferred: short names when no conflicts
@Query("SELECT i FROM Institution i WHERE i.id = :institutionId")
Optional<Institution> findInstitutionBy(Long institutionId);

@Query("SELECT c FROM Child c WHERE c.classGroup.id = :classGroupId AND c.isActive = true")
List<Child> findChildrenBy(Long classGroupId);

// When conflicts occur (both methods take String), first gets short name:
@Query("SELECT u FROM User u WHERE u.email = :email")
Optional<User> findUserBy(String email);

// Subsequent methods with same parameter type get field name:
@Query("SELECT u FROM User u WHERE u.activationToken = :activationToken")
Optional<User> findUserByActivationToken(String activationToken);

// Exists checks use entityExistsBy pattern (no "And" separators):
boolean treasurerClassGroupExistsBy(Long userId, Long classGroupId);
```

**Prefer entity objects over raw IDs as parameters.** When a service already holds a `ClassGroup` (or other entity) from a `findValid` call, pass it directly to the repository instead of extracting its ID. For view-entities without JPA relations, use SpEL to dereference the ID in the query:

```java
// ✅ Pass entity — call site already holds it from findValidClassGroup
@Query("SELECT cb FROM ChildBalance cb WHERE cb.classGroupId = :#{#classGroup.id} AND cb.isActive = true")
List<ChildBalance> findChildBalancesBy(ClassGroup classGroup, Sort sort);

// ✅ Pass entity — JPA relation available on normal entity
// Use path projection (SELECT t.relation) — Spring Data Sort works correctly on the returned type.
// Avoid explicit JOIN alias (JOIN tcg.treasurer u + SELECT u) — Hibernate applies Sort to the root entity, not the join alias.
@Query("SELECT t.treasurer FROM TreasurerClassGroup t WHERE t.classGroup = :classGroup")
List<AppUser> findTreasurersBy(ClassGroup classGroup, Sort sort);

// ❌ Raw ID — caller already has the entity, extracting ID throws away the object
List<ChildBalance> findChildBalancesBy(Long classGroupId, Sort sort);
```

---

### MapStruct Mapper Method Naming

**Mapper method names must include the return type name** — do not use generic `toDto` or `toEntity`:

```java
// ✅ Return type is explicit in method name
UserDto toUserDto(AppUser user);
AppUser toAppUser(UserCreateRequest request);
List<UserDto> toUserDtos(List<AppUser> users);

// ❌ Generic names — unclear when mapper has multiple methods
UserDto toDto(AppUser user);
AppUser toEntity(UserCreateRequest request);
```

**Pattern:** `to{ReturnTypeName}(SourceType source)`

**Always map all fields explicitly**, including fields where source and target names match — do not rely on implicit mapping:

```java
// ✅ All fields explicit
@Mapping(source = "id", target = "userId")
@Mapping(source = "firstName", target = "firstName")
@Mapping(source = "lastName", target = "lastName")
@Mapping(source = "email", target = "email")
UserDto toUserDto(AppUser user);

// ❌ Implicit mapping — hides what is actually mapped
@Mapping(source = "id", target = "userId")
UserDto toUserDto(AppUser user);
```

**Always use a mapper to construct entities from request DTOs** — do not build entities manually in service methods. If the mapper needs to set business-logic defaults (e.g. a fixed role or activation state), use `@Mapping(target = "field", constant = "value")`.

**Mapper methods always live in the interface named after the entity** — regardless of which direction the mapping goes. This makes it easy to find existing mappings and avoid duplication:

```java
// ✅ AppUserMapper owns all mappings where AppUser is the entity
AppUser toAppUser(UserCreateRequest request);   // DTO → Entity
AppUser toAppUser(AddParentRequest request);    // different DTO, same entity — same mapper
UserDto toUserDto(AppUser user);                // Entity → DTO

// ❌ Separate ParentMapper for AppUser — wrong owner
@Mapper
public interface ParentMapper {
    AppUser toAppUser(AddParentRequest request);  // AppUser is the entity → belongs in AppUserMapper
}
```

**Always use MapStruct for DTO ↔ Entity conversion** — even when the mapper needs to set business-logic defaults. Use `@Mapping(target = "field", constant = "value")` for fixed values instead of building the entity manually in the service:

```java
// ✅ Mapper handles defaults — service calls one line
@Mapping(target = "userRole", constant = "PARENT")
@Mapping(target = "isActive", constant = "true")
@Mapping(target = "isActivated", constant = "false")
AppUser toAppUser(AddParentRequest request);

// ❌ Service manually constructs entity — that is the mapper's job
private AppUser buildParent(AddParentRequest request) {
    AppUser parent = new AppUser();
    parent.setUserRole(UserRole.PARENT);
    ...
}
```

**For list mappings**, add a separate method without annotations — MapStruct generates it automatically by delegating to the single-object method:

```java
@Mapping(source = "id", target = "institutionId")
@Mapping(source = "name", target = "name")
@Mapping(source = "shortName", target = "shortName")
@Mapping(source = "city", target = "city")
InstitutionDto toInstitutionDto(Institution institution);

List<InstitutionDto> toInstitutionDtos(List<Institution> institutions);
```

---

### Unit Testing

**Every service implementation must be covered by unit tests.**

Place test files in the corresponding `src/test/java/...` package, mirroring the `src/main` structure.

**Conventions:**
- `@ExtendWith(MockitoExtension.class)` + `@Mock` / `@InjectMocks`
- Test method name format: `methodName_expectedBehavior_whenCondition`
- Use AssertJ assertions: `assertThat`, `assertThatThrownBy`
- For error cases, also verify the `errorCode` field

**What to test:**
- Happy path — data is saved / returned correctly
- Error cases — correct exception and `ErrorCode` are thrown
- Side effects — `verify(repository).save(...)`, `verify(..., never()).save(...)`

```java
@Test
void createClassGroup_savesClassGroup_whenInstitutionExists() {
    when(institutionService.findValidInstitution(1L)).thenReturn(institution);
    when(classGroupMapper.toClassGroup(request)).thenReturn(classGroup);

    classGroupService.createClassGroup(1L, request);

    assertThat(classGroup.getInstitution()).isEqualTo(institution);
    verify(classGroupRepository).save(classGroup);
}

@Test
void createClassGroup_throwsIdNotFound_whenInstitutionDoesNotExist() {
    when(institutionService.findValidInstitution(99L))
            .thenThrow(new IdNotFoundException(ErrorCode.INSTITUTION_NOT_FOUND, 99L));

    assertThatThrownBy(() -> classGroupService.createClassGroup(99L, request))
            .isInstanceOf(IdNotFoundException.class)
            .satisfies(ex -> assertThat(((IdNotFoundException) ex).getErrorCode())
                    .isEqualTo(ErrorCode.INSTITUTION_NOT_FOUND));

    verify(classGroupRepository, never()).save(any());
}
```

---

### DTO Style

**Prefer `record` for response DTOs** when all fields are known at construction time:

```java
// ✅ All fields set at once — use record
public record ClassGroupHeaderDto(String classGroupName, String academicYear) {}

// ❌ Unnecessary class when record works
@Getter @Setter
public class ClassGroupHeaderDto { ... }
```

Use a `class` (with Lombok) when fields must be set incrementally after construction — e.g. when part of the data comes from the DB and additional fields are computed or fetched separately:

```java
// ✅ Fields populated in steps — class is appropriate
@Getter @Setter
public class ClassGroupBalanceDto {
    private String classGroupName;
    private BigDecimal totalBalance; // computed after DB fetch
}
```

For request DTOs, follow the existing style in the same package.

---

### Long Annotation Strings — Use Text Blocks

When an `@Operation` description or `@ApiResponse` description lists multiple items or runs long, use a `"""` text block and split across lines. One-liners are fine as-is.

