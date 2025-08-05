# Flutter Base Project

## Development Notes

### Project Structure
This project follows Clean Architecture principles with feature-first organization.

### Code Generation Commands
```bash
# Generate localization
flutter gen-l10n

# Generate injectable dependencies  
flutter packages pub run build_runner build

# Watch mode for development
flutter packages pub run build_runner watch
```

### Environment Setup
1. Copy environment files and update with your values
2. Initialize Firebase project (optional)
3. Configure Sentry DSN (optional)

### Testing
- Unit tests: `test/`
- Widget tests: `test/widget_test/`
- Integration tests: `integration_test/`

### CI/CD
Configure your CI/CD pipeline to:
1. Run tests
2. Build for multiple platforms
3. Deploy to stores/distribution

### Performance Tips
- Use const constructors where possible
- Implement proper error boundaries
- Monitor memory usage with dev tools
- Use cached_network_image for images
- Implement proper loading states

### Security Checklist
- [ ] Secure API endpoints
- [ ] Implement proper authentication
- [ ] Use HTTPS only
- [ ] Validate all user inputs
- [ ] Implement rate limiting
- [ ] Store sensitive data securely
