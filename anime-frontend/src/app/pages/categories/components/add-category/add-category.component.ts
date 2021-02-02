import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import {ActivatedRoute, Router} from '@angular/router';
import {CategoryService} from '../../services/category.service';
import { ImageSnippet } from '../../entity/image-snippet';
import { ToastrService } from 'ngx-toastr';
import { TokenService } from 'src/app/pages/admin-service/token/token.service';

@Component({
  selector: 'app-add-category',
  templateUrl: './add-category.component.html',
  styleUrls: ['./add-category.component.scss']
})
export class AddCategoryComponent implements OnInit {
  isSubmitted = false;
  uploadForm: FormGroup;
  uploadButtonValue = 'Upload';
  imageName = 'Select Image';
  fileSelected = false;
  fileUploaded = false;
  imageUrl: string;
  imagePathReady = false;
  submitButtonValue = 'Waiting Uploading Image';
  selectedFile: ImageSnippet;

  constructor(private categoryService: CategoryService,
              private tokenService: TokenService,
              private formBuilder: FormBuilder,
              private toaster: ToastrService,
              private router: Router,
              private activatedRoute: ActivatedRoute) {
  }

  ngOnInit() {
    // Fetch Form Data
    this.uploadForm = this.formBuilder.group({
      name: ['', [Validators.required, Validators.minLength(2)]],
      description: ['', [Validators.required, Validators.minLength(2)]],
      image: [''],
    });
  }

  updateName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.uploadButtonValue = 'Upload';
    this.imageName = file.name;
    this.fileSelected = true;
  }

  processFile(imageInput: any) {
    this.fileSelected = false;
    this.uploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();
    
    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.categoryService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          console.log(res);
          this.imageUrl = res;
          this.uploadButtonValue = 'Uploaded';
          this.imagePathReady = true;
          this.submitButtonValue = 'New Category';
        },
        (err) => {
          console.log(err);
        });
    });
    reader.readAsDataURL(file);
  }


  mySubmit() {
    this.isSubmitted = true;
    
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : Form Not Valid');
      this.isSubmitted = false;
      return false;
    } else {
      // Fetch All Form Data On Json Type
      const formObject = this.uploadForm.getRawValue();
      formObject.createdBy = this.tokenService.userName;
      formObject.image = this.imageUrl;

      this.categoryService.createCategory(formObject).subscribe(
        (createResponse: any) => console.log(createResponse),
        error => {
          this.isSubmitted = false;
          console.log('Error : ', error);
        },
        () => {
          this.router.navigate(['../'], {relativeTo: this.activatedRoute});
        }
      );
    }
  }


}
